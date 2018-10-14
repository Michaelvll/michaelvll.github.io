all:
	cd ./CV &&	xelatex ./resume.tex -output-directory=../
	copy resume.pdf cv.pdf 
	del resume.*

clean:
	del resume.*