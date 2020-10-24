	#git clone https://github.com/gerby-project/plastex.git
	#cd plastex
	#git checkout gerby
	#pip install .
	#cd ..

  #git clone git@github.com:dzackgarza/kerodon-website.git gerby-website
	#cd gerby-website/gerby/static
	#git clone https://github.com/aexmachina/jquery-bonsai
	#cp jquery-bonsai/jquery.bonsai.css css/
	#cd ../..
	#pip install -e . # we use -e because we want to change the source files
	#cd ..

	#mv configuration.py gerby-website/gerby/configuration.py

	#cd gerby-website/gerby/tools
	#ln -sf ../../../document      document
	#ln -sf ../../../document.paux document.paux
	#ln -sf ../../../tags          tags
	#cd ../../..

	#cd gerby-website
	#ln -sf gerby/tools/hello-world.sqlite hello-world.sqlite
	#ln -sf gerby/tools/comments.sqlite    comments.sqlite
	#cd ..


	python3 tagger.py >> tags
	plastex --renderer=Gerby ./document.tex
	cd gerby-website/gerby/tools
	python3 update.py
	cd ../..
	export FLASK_APP=gerby
	python3 -m flask run;
