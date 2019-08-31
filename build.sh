#!/bin/bash

source ~/.bash_profile
bundle install -j4 --path vendor/bundle
zip nomura_scraper.zip -r *
