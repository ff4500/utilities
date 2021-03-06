#!/usr/bin/env bash

# if [ ! -z "$p" ]; then
#   article_dir="${news_dir}/${p}"
#   echo "${article_dir}"
# fi

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
    article_dir="${news_dir}/${p}"
    #echo "${article_dir}"
    if [ -d "${article_dir}" ]; then
      echo -e "${p} already exists - please enter a different name."
    else
      mkdir "${article_dir}"
      #echo -e "Made your folder. Go check it out."
    fi
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
  if [ ! -z "$p" ]; then
    cp "${template_dir}/news_template.md" "${article_dir}/${p}.md"
    cp "${template_dir}/template.psd" "${article_dir}/${p}_template.psd"
  else
    cp "${template_dir}/news_template.md" "${news_dir}/${file_dir}/${file_dir}.md"
    cp "${template_dir}/template.psd" "${news_dir}/${file_dir}/${file_dir}_template.psd"
  fi
  mkdir "${news_dir}/${file_dir}/source"
}

# -----

run() {
  mk_news
  mk_folder
  cp_templates
  echo
  echo -e "------------------------------------------------------------"
  echo
  echo -e "  Your news article directory is ready!"
  echo
  echo -e "  Check it out here:"
  echo -e "  ${news_dir}/${file_dir}"
  echo
  echo -e "------------------------------------------------------------"
}
