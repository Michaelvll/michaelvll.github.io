cv:
	cd ../CV && git pull && xelatex ./resume_cv.tex -output-directory=./
	copy ..\CV\resume_cv.pdf assets\cv.pdf 
	git add assets\cv.pdf && git commit -m"Update CV" && git push

clean:
	del ..\resume_cv.*
