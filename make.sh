#! /bin/bash

# 1) install plasTeX
git clone https://github.com/gerby-project/plastex.git
cd plastex
# use the Gerby branch of plasTeX
git checkout gerby
# actual install
pip install .
cd ..


# 2) install Gerby
git clone git@github.com:dzackgarza/kerodon-website.git gerby-website
cd gerby-website/gerby/static
# import jQuery Bonsai
git clone https://github.com/aexmachina/jquery-bonsai
cp jquery-bonsai/jquery.bonsai.css css/
# actual install
cd ../..
pip install -e . # we use -e because we want to change the source files
cd ..

# 3) setup configuration
mv configuration.py gerby-website/gerby/configuration.py

# 4) setup soft links for plasTeX output
cd gerby-website/gerby/tools
ln -s ../../../document      document
ln -s ../../../document.paux document.paux
ln -s ../../../tags          tags
cd ../../..

# 5) setup soft links for database
cd gerby-website
ln -s gerby/tools/hello-world.sqlite hello-world.sqlite
ln -s gerby/tools/comments.sqlite    comments.sqlite
cd ..


# 1) update tags file with new tags
python3 tagger.py >> tags
# in real life: first run it without writing it to the tags file to check for errors

# 2) convert to HTML: output goes to document/
plastex --renderer=Gerby ./document.tex

# 3) import plasTeX output into database
cd gerby-website/gerby/tools
python3 update.py
cd ../..

# 4) run Flask
lsof -ti tcp:5000 | xargs kill
export FLASK_APP=gerby
python3 -m flask run &
