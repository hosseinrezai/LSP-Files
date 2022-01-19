(defun c:faseleazshorokhat ()
  (vl-load-com)
  (setq oldosnap (getvar "osmode"))
  (setvar "osmode" 0)
  (command "ucs" "w")
  (setvar "pdmode" 3); if your pdmode is already set to what you want, remove or comment this line
  (setq ob (entsel "Select curve: "))
  (setq obj (vlax-ename->vla-object (car ob)))
  (command "ucs" "p")
  (setvar "osmode" oldosnap)
  (while (setq rad (getreal "\n fasele az shoro khat:"	))
	(progn
	  (setq right (getreal "\n tol khat:"	))
	  (princ)
		  (command "_.line"
			   (vlax-curve-getPointAtDist (vlax-ename->vla-object (car ob)) rad)
			   (polar
			 (vlax-curve-getPointAtDist (vlax-ename->vla-object (car ob)) rad)
			 (- (angle (vlax-curve-getPointAtDist (vlax-ename->vla-object (car ob)) (+ rad 0.1)) (vlax-curve-getPointAtDist (vlax-ename->vla-object (car ob)) (- rad 0.1))) (/ pi 2))
			 right
			 )
			   "")
			   )
			   )
)

;;********************************************************************************************************************************************

(defun c:polcod()
  (setq	mabna (getpoint "\\n khat mabna:"))
  (setq mabnael (getreal "code mabna:"))
  (while  (setq p (getpoint "\nnoghte code:"))
    (command "._MLEADER" "o" "a" "y" 0.26 "x" p (list (nth 0 p) (+ (nth 1 p) 0.8) 0) (rtos (+ (- (nth 1 p) (nth 1 mabna)) mabnael) 2 2))
    )
  
  )
(defun c:polcod1()
  (setq	mabna (getpoint "\\n khat mabna:"))
  (setq mabnael (getreal "code mabna:"))
  (while  (setq p (getpoint "\nnoghte code:"))
    (command "._MLEADER" "o" "a" "y" "x" p (list (nth 0 p) (+ (nth 1 p) 0.8) 0) (rtos (+ (- (nth 1 p) (nth 1 mabna)) mabnael) 2 2))
    )
  
  )

;;********************************************************************************************************************************************
(defun c:gharniz()
  (setq zgharniz 0.25)
  (setq xgharniz 0.3)
  (setq xabchakan 0.05)
  (setq pakhi 0.03)
  (setq osvar (getvar 'OSMODE))
  (setvar 'OSMODE 1)
  (setq p (getpoint "\n dal:"))
  (setq ps (getpoint "\n jlo pol:"))
  (setvar 'OSMODE 0)
  (if (> (nth 0 ps) (nth 0 p))
    (progn
      (command "_.line"
	       p
	       (list (nth 0 p) (- (+ (nth 1 p) zgharniz) pakhi))
	       (list (+ (nth 0 p) pakhi) (+ (nth 1 p) zgharniz))
	       (list (- (+ (nth 0 p) xgharniz xabchakan) pakhi) (+ (nth 1 p) zgharniz))
	       (list (+ (nth 0 p) xgharniz xabchakan) (- (+ (nth 1 p) zgharniz) pakhi))
	       (list (+ (nth 0 p) xgharniz xabchakan) (nth 1 p))
	       (list (+ (nth 0 p) xgharniz (/ xabchakan 1.333)) (nth 1 p))
	       "")
      (command "_.arc"
	       "c"
	       (list (+ (nth 0 p) xgharniz (/ xabchakan 2)) (nth 1 p))
	       (list (+ (nth 0 p) xgharniz (/ xabchakan 1.333)) (nth 1 p))
	       (list (+ (nth 0 p) xgharniz (/ xabchakan 4)) (nth 1 p))
	       "")
      (command "_.line"
	       (list (+ (nth 0 p) xgharniz (/ xabchakan 4)) (nth 1 p))
	       (list (+ (nth 0 p) xgharniz) (nth 1 p))
	       (list (+ (nth 0 p) xgharniz) (- (nth 1 p) 1) )
	       "")
      ))
      (if (< (nth 0 ps) (nth 0 p))
    (progn
      (command "_.line"
	       p
	       (list (nth 0 p) (- (+ (nth 1 p) zgharniz) pakhi))
	       (list (- (nth 0 p) pakhi) (+ (nth 1 p) zgharniz))
	       (list (+ (- (nth 0 p) xgharniz xabchakan) pakhi) (+ (nth 1 p) zgharniz))
	       (list (- (nth 0 p) xgharniz xabchakan) (- (+ (nth 1 p) zgharniz) pakhi))
	       (list (- (nth 0 p) xgharniz xabchakan) (nth 1 p))
	       (list (- (nth 0 p) xgharniz (/ xabchakan 1.333)) (nth 1 p))
	       "")
      (command "_.arc"
	       "c"
	       (list (- (nth 0 p) xgharniz (/ xabchakan 2)) (nth 1 p))
	       (list (- (nth 0 p) xgharniz (/ xabchakan 4)) (nth 1 p))
	       (list (- (nth 0 p) xgharniz (/ xabchakan 1.333)) (nth 1 p))
	       "")
      (command "_.line"
	       (list (- (nth 0 p) xgharniz (/ xabchakan 4)) (nth 1 p))
	       (list (- (nth 0 p) xgharniz) (nth 1 p))
	       (list (- (nth 0 p) xgharniz) (- (nth 1 p) 1) )
	       "")
      ))
    (setvar 'OSMODE osvar )
  )

;;********************************************************************************************************************************************

(defun c:xoy()
  (setq p (getpoint "\n point:"))
  (setq x (strcat "x=" (rtos (nth 0 p)) "\n y=" (rtos (nth 1 p))))
  (command "_.leader" p (getpoint "\n text point:") "a" x "")
  )

;;********************************************************************************************************************************************

(defun c:xoyoz()
  (setq p (getpoint "\n point:"))
  (setq x (strcat "x=" (rtos (nth 0 p)) "\n y=" (rtos (nth 1 p)) "\n z=" (rtos (nth 2 p))))
  (command "_.leader" p (getpoint "\n text point:") "a" x "")
  )
;;**********************************************************************************************************************************************
(defun c:khatbashib()
  (setq p (getpoint "\n noghte obor:"))
  (setq left (getreal "\n az chap:"))
  (setq right (getreal "\n az rast:"))
  (setq shib (getreal "\n az shib be darsad:"))
  (setq o (getvar 'OSMODE))
  (setvar 'OSMODE 0)
  (command "_.line"
	   (list (- (nth 0 p) left) (- (nth 1 p) (* (/ shib 100) left)))
	   (list (+ (nth 0 p) right) (+ (nth 1 p) (* (/ shib 100) right)))
	   "")
  (setvar 'OSMODE o)  
  )
  ;;********************************************************************************************************************************************
  (defun c:daronyabi()
  (setq x1 (getreal "x1:"))
  (setq y1 (getreal "y1:"))  
  (setq x2 (getreal "x2:"))
  (setq y2 (getreal "y2:"))
  (setq x (getreal "x:"))
  (princ "y:")
  (+ y1 (* (- x x1) (/ (- y2 y1) (- x2 x1))))
  )
  ;;******************************************************************************************************************************************************
  (defun c:psateregular()
  (setq tsatr (- (getreal "\n tedad satr:") 1))  
  (setq tston (- (getreal "\n tedad ston:") 1))
  (setq fsatr (getreal "\n fasele satr:"))  
  (setq fston (getreal "\n fasele ston:"))
  (setq basepoint (getpoint "\n Start point:"))
  (setq i 0)
  (while (<= 0 tston)
    	(if (< tsatr i)
		(progn
		  (setq tston (- tston 1))
		  (setq i 0)
		  )
	  	(progn
			(command "_.pasteclip" (list (+ (nth 0 basepoint) (* tston fston)) (+ (nth 1 basepoint) (* i fsatr))))
		  	(setq i (+ i 1))
		  )
	  )
    )
  )
;;******************************************************************************************************************************************************
(defun c:printregular()
  (setq tsatr (- (getreal "\n tedad satr:") 1))  
  (setq tston (- (getreal "\n tedad ston:") 1))
  (setq fsatr (getdist "\n fasele satr:"))  
  (setq fston (getdist "\n fasele ston:"))
  (setq tl (getpoint "\n Bala Chap:"))  
  (setq br (getpoint "\n Pain Rast:"))
  (setq i 0)
  (while (<= 0 tston)
    	(if (< tsatr i)
		(progn
		  (setq tston (- tston 1))
		  (setq i 0)
		  )
	  	(progn
  (command "_.PLOT"
				 "YES" 				;PLOT Detailed plot configuration? [Yes/No] <No>: nil
				 "Layout1" 			;Enter a layout name or [?] <Model>:
				 "EPSON Stylus Photo 1410"
				 "A4 210 x 297 mm"		;Enter paper size or [?] <30×112>:
				 "Millimeters"			;Enter paper units [Inches/Millimeters] <Millimeters>: M
				 "Landscape"			;Enter drawing orientation [Portrait/Landscape] <Landscape>: L
				 "NO"				;Plot upside down? [Yes/No] <No>: Y
				 "Window"			;Enter plot area [Display/Extents/Limits/View/Window] <Display>: W
				 (List (+ (nth 0 tl) (* fston tston)) (+ (nth 1 tl) (* i fsatr)))	;Enter lower left corner of window
  				 (list (+ (nth 0 br) (* fston tston)) (+ (nth 1 br) (*  i fsatr)))
				 "Fit"				;Enter plot scale (Plotted Millimeters=Drawing Units) or [Fit] <Fit>:
				 "Center"			;Enter plot offset (x,y) or [Center] <0.00,0.00>:
				 "Yes"				;Plot with plot styles? [Yes/No] <Yes>:
				 "."				;Enter plot style table name or [?] (enter . for none) <>:
				 "Yes"				;Plot with lineweights? [Yes/No] <Yes>:
				 "As displayed"			;Enter shade plot setting [As displayed/legacy Wireframe/legacy Hidden/Visual styles/Rendered] <As displayed>:
				 "No"				;Write the plot to a file [Yes/No] <N>:
				 "No"				;Save changes to page setup [Yes/No]? <N>
				 "Yes"				;Proceed with plot [Yes/No] <Y>:
				 )
		  	(setq i (+ i 1))
		  )
	  )
    )
  )
