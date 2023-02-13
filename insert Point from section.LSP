(defun c:InsertPointFromSection()
  (setq thelist (list ))
  (setq PointDescribtion "")
  (if (< (getvar 'DATE) 2460196)
    (progn
      (vl-load-com)
      (setq oldosnap (getvar "osmode"))
      (setvar "osmode" 0)
      (command "ucs" "w")
      (setvar "pdmode" 3)
      (initget "New Continue")
      (setq ans (cond ((getkword "\nChoose [New AX/Continue with the AX] <New AX>: ")) ("New")))
      (if (= ans "New")
	(progn
	  (setq axob (entsel "Select Ax: "))
	  (setq StartKM (getreal "\n Enter start km:"))
	  )
	)
      (initget "New Continue")
      (setq ans (cond ((getkword "\nChoose [New zoom option/Continue with last option] <Continue with last option>: ")) ("Continue")))
      (if (= ans "New")
	(progn
	  (setq xscreenmove (getdist "\n X Screen pan: "))
	  (setq yscreenmove (getdist "\n Y Screen pan: "))
	  )
	)
      (command "ucs" "p")
      (while (setq SectionKM (getreal "\n Section KM:"	))
	(progn
	  (setq offsetinKM (- SectionKM StartKM))
	  (setvar "osmode" 1)
	  (setq datumpoint (getpoint "\nselect datum point:"))
	  (setq datumcode (getreal "\ndatumcode:"))
	  (setvar "osmode" 512)
	  (setq AxInSection (getpoint "\nselect a point on Ax:"))
	  (setvar "osmode" 0)
	  (while (setq secob (car (entsel (strcat "\n(" PointDescribtion " with " (rtos (/ (length thelist) 2) 2 0) " points added)Select the Polyline in section: "))))
	    (progn
	      (setq secobj (vlax-ename->vla-object secob))
	      (if (= (vlax-get-property secobj 'ObjectName) "AcDbPolyline")
		(progn
		  (setq thelist (vlax-get-property secobj 'coordinates))
		  (setq thelist (vlax-safearray->list  (variant-value thelist)))
		  (setq PointDescribtion (getstring "\nEnter a describtion for points:"))
		  (setq n 0)
		  (repeat (/ (length thelist) 2)
		    (setq xval (nth n thelist))
		    (setq n (1+ n))
		    (setq yval (nth n thelist))e
		    (setq n (1+ n))
		    (setq xval  (- (nth 0 AxInSection) xval))
		    (setq yval  (+ datumcode (- yval (nth 1 datumpoint))))
		    (command "createpointmanual"
			     (polar
			       (vlax-curve-getPointAtDist (vlax-ename->vla-object (car axob)) offsetinKM)
			       (- (angle (vlax-curve-getPointAtDist (vlax-ename->vla-object (car axob)) (+ offsetinKM 0.1)) (vlax-curve-getPointAtDist (vlax-ename->vla-object (car axob)) (- offsetinKM 0.1))) (/ pi 2))
			       xval
			       )
			     PointDescribtion
			     yval
			     ""
			     )
		    )
		  )
		(alert "This is not a Polyline! - Please try again.")
		)
	      )
	    )
	  (command "_.zoom"
		   "C"
		   (list (+ (nth 0 (getvar 'viewctr)) xscreenmove) (+ (nth 1 (getvar 'viewctr)) yscreenmove))
		   (getvar 'viewsize)
		   )
	  )
	)
  (setvar "osmode" oldosnap)
      )
    )      
)