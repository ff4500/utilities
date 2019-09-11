#!/usr/bin/env bash

base_dir="./news_articles"
news_dir="${base_dir}/news"
template_dir="${base_dir}/_templates"

user_parameter="$1"
p="${user_parameter}"

if [ ! -z "$p" ]; then
  article_dir="${news_dir}/${p}"
  echo "${article_dir}"
else
  article_dir="${news_dir}/zzz" #${article_dir_cli}"
  echo "${article_dir}"
fi

mk_news() {
  if [ ! -d "${base_dir}" ]; then
    mkdir "${base_dir}"
  fi
  if [ ! -d "${news_dir}" ]; then
    mkdir "${news_dir}"
  fi
  if [ ! -d "${template_dir}" ]; then
    echo -e "Something is seriously wrong."
    echo -e "The template directory is missing."
    echo -e "It should be here: ${template_dir}"
    echo -e "You probably want to check and make sure you didn't delete the dir and try running this script again."
    exit 0
  fi
}

mk_folder() {
  if [ ! -z "$p" ]; then
    mkdir "${news_dir}/${p}"
    #echo "$p"
  else
    while read -ep "Enter the name of the article to create: " file_dir; do
      if [ -d "${news_dir}/${file_dir}" ]; then
        echo -e "${file_dir} already exists - please enter a different name."
      else
        mkdir "${news_dir}/${file_dir}"
        #echo -e "Made your folder. Go check it out."
        break
      fi
    done
  fi
}

cp_templates() {
  cp "${template_dir}/news_template.md" "${news_dir}/${file_dir}/${file_dir}.md"
  cp "${template_dir}/template.psd" "${news_dir}/${file_dir}/${file_dir}_template.psd"
}

#mk_news
#mk_folder
#cp_templates
