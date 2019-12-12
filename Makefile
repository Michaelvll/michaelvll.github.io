all: cv deploy

cv:
	cd ../CV; git pull; xelatex ./resume_cv.tex -output-directory=./
	cp ../CV/resume_cv.pdf assets/pdf/Zhanghao_Wu_CV.pdf 
	git add assets/pdf/Zhanghao_Wu_CV.pdf; git commit -m"Update CV"; git push

run:
	bundle exec jekyll serve

deploy: clean
	git add .; git commit -m"update"; git push
	./bin/deploy --user -s

clean:
	rm ./_site ./2018 ./2019 ./publication -rf