#!/bin/bash

source ~/.bash_profile
bundle install -j4 --path vendor/bundle

if [ -e nomura_scraper.zip ]; then
    rm nomura_scraper.zip
fi

zip nomura_scraper.zip -r *
