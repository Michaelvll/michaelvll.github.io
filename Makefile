all:
	cd ./CV &&	xelatex ./resume_cv.tex -output-directory=../
	copy resume_cv.pdf cv.pdf 
	del resume_cv.*

clean:
	del resume_cv.*