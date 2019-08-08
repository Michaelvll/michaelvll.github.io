all:
	cd ../CV && git pull && xelatex ./resume_cv.tex -output-directory=./
	copy ..\CV\resume_cv.pdf assets\cv.pdf 

clean:
	del ..\resume_cv.*
