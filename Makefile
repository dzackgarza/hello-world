SHELL:=/bin/zsh

update:
	python3 tagger.py >> tags;
	echo y | plastex --renderer=Gerby ./document.tex;
	cd gerby-website/gerby/tools && python3 update.py
	cd gerby-website && export FLASK_APP=gerby && python3 -m flask run;
