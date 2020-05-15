#!/usr/bin/env bash

ind="  "
sep_ll="100"
cdate=$(date '+%F')

# Indention - for reuse
# -----------------------------------------------
indent() {
  printf "${ind}"
}

# Seperators
# -----------------------------------------------
sep() {
  local ch="-"
  local sep_line="$(printf '%*s' "${sep_ll}" | tr ' ' "$ch")"
  echo -e "${ind}${fg_darkgrey_01}${sep_line}${reset}${ind}"
}

info(){
  indent; indent; echo -e "${bg_darkgrey_02}${ui_text_info} i ${reset} \c"
}

action(){
  indent; indent; echo -e "${bg_darkgrey_02}${ui_text_info} > ${reset} \c"
}

action_title(){
  indent; indent; echo -e "${bg_aqua}${fg_black} $1 ${reset}"
}

action_indent(){
  indent; indent; indent; indent;
}

cmd(){
  # indent; indent; echo -e "${bg_darkgrey_02}   ${reset}"
  # echo;
  # indent; indent; echo -e "${bg_darkgrey_02}${ui_text_cmd} > ${reset}${fg_lightgrey} \$ ${reset}\c"
  indent; indent; indent; indent; echo -e "${bg_black}${ui_text_cmd} \$ $1 ${reset}"
}

cmd_inline(){
  echo -e "${bg_black}${ui_text_cmd} \$ $1 ${reset}"
}

cmd_inline_noprompt(){
  echo -e "${bg_black}${ui_text_cmd} $1 ${reset}"
}

sec_hl(){
  indent; indent; echo -e "${bg_darkpurple} $1 ${reset}";
  echo
}

line(){
  echo -e $1
}

line_i(){
  indent; indent; echo -e $1
}

line_2(){
  indent; indent; echo -e "    \c"; echo -e $1
}

alert_line(){
  indent; indent; echo -e "${bg_red}${fg_white} ! ${reset} \c"; echo -e "${fg_red}$1${reset}"
}

titleblock() {
  local title_length="$(echo -e "${title}" | awk '{print length}')" #gets the length of the title var
  local title_sp="$(($((sep_ll-title_length))/2))" #subtract the length of the title from the seperator, divide by 2
  local sp="$(printf "%*s%s" $title_sp '' "$sp")" #printf that amount of empty spaces (with sed) to a var called "sp"
  local line="$(printf "%*s%s" $sep_ll '' "$line")" #print empty spaces the length of the "sep_ll" var

  clear; echo
  echo -e "${ind}${bg_darkpurple}${line}${reset}"
  echo -e "${ind}${bg_darkpurple}${sp}${title}${sp}${reset}"
  echo -e "${ind}${bg_darkpurple}${line}${reset}"
}

prompt_continue(){
  indent; indent; echo -e "${fg_lightgrey}\c"; read -n 1 -s -r -p "Press any key to continue... "; echo -e "${reset}"
}

# Check directory/file existence
# -----------------------------------------------

check_ex(){
  echo
  sep
  echo

  sec_hl "Checking for required files/folders:"

  if [ ! -d "${base_dir}" ]; then
    alert_line "Base dir doesn't exist. ${reset}"; sleep 1;
    line_2 "Making it now. \c"; sleep 1; cmd_inline "mkdir ${base_dir}"
    echo; sleep 1
    mkdir ${base_dir}
  else
    info; line "Base dir exists at: \c"; cmd_inline_noprompt "${base_dir}"
    echo
  fi

  if [ ! -d "${source}" ]; then
    alert_line "Source dir doesn't exist. ${reset}"; sleep 1;
    line_2 "Making it now. \c"; sleep 1; cmd_inline "mkdir ${source}"
    echo; sleep 1
    mkdir ${source}
  else
    info; line "Source dir exists at: \c"; cmd_inline_noprompt "${source}"
    echo
  fi

  if [ ! -d "${output}" ]; then
    alert_line "Output dir doesn't exist. ${reset}"; sleep 1;
    line_2 "Making it now. \c"; sleep 1; cmd_inline "mkdir ${output}"
    echo; sleep 1
    mkdir ${output}
  else
    info; line "Output dir exists at: \c"; cmd_inline_noprompt "${output}"
    echo
  fi

  if [ ! -f "${repo_list}" ]; then
    alert_line "A repository list doesn't exist. ${reset}"; sleep 1;
    line_2 "Making the ${bg_aqua} _src ${reset} dir and an empty list now. \c"; sleep 1; cmd_inline "touch ${repo_list}"
    echo; sleep 1
    mkdir ${base_dir}/_src && touch ${repo_list}
  else
    info; line "A repository list exists at: \c"; cmd_inline_noprompt "${repo_list}"
    echo
  fi

  sep
  echo
}

color_yn() {
  echo -e "${fg_lightgrey}(yes/no):${reset} "
}

user_prompt_continue() {
  sep
  echo
  indent; indent; echo -e "${fg_lightgrey}\c"; read -r -p "Would you like to continue? $(color_yn)" response
  if [[ $response =~ (y|yes|Y|YES|yep|yup) ]]; then
    echo
    info; line "You said YES. \c";
    sleep 1s;
    line "Let's go!";
    echo
    sleep 1s;
    clear
  else
    echo
    info; line "You said NO ${fg_lightgrey}(or didn't type y|yes|Y|YES|yep|yup)${reset}";
    echo
    sleep .5s;
    line_i "${bg_darkpurple} Exiting... ${reset}";
    echo
    echo
    sleep 1s;
    exit 0;
  fi
}

# Check if repo_list.txt is empty

repo_list_empty_check(){
  echo
  sep
  echo

  sec_hl "Checking for repositories:"

  if [ ! -s "${repo_list}" ]; then
    alert_line "There aren't any repos defined in your list yet."; line_2 "Add them to ${bg_black}${fg_aqua} ${repo_list} ${reset}"; line_2 "and restart this script."
    echo
    sep
    echo
    sleep 2s;
    exit 0;
  else
    info; line "Here's your list. The following repos will be processed:"
    echo -e "${fg_aqua}"
    cat ${repo_list} | sed 's/^/    /g'
    echo -e "${reset}"
    user_prompt_continue
  fi
}

github_clone() {
  # Clone everything in repo_list to source folder
  # -----------------------------------------------

  while read line; do   

    suffix=".git"
    pre="${line##*/}"
    pre=${pre%"${suffix}"}
    reponame="${pre}"

    echo
    sep
    echo

    sec_hl "Processing ${fg_aqua}${reponame} ${reset}"
    
    if [ ! -d "${source}/${reponame}" ]; then
      info; line "Repo directory doesn't exist. \c"; sleep 1; line "${fg_aqua}Creating it now.${reset}"; sleep 1;
      mkdir "${source}/${reponame}";
    else
      info; line "Repo directory already exists. \c"; sleep 1; line "${fg_aqua}Deleting it and making a fresh copy.${reset}"; sleep 1;
      rm -rf "${source}/${reponame}" && mkdir "${source}/${reponame}";
    fi

    echo
    
    # cd "${source}/${reponame}";
    # ls -la;
    # pwd

    action_title "RUNNING";
    echo

    action; cmd_inline "git clone ${reponame}";
    git -C "${source}/${reponame}/" clone -q $line;
    
    action; cmd_inline "git clone MIRROR ${reponame}";
    git -C "${source}/${reponame}/" clone --mirror -q $line;
    
    echo

    # Make a bundle file out of the mirror repo copy
    # -----------------------------------------------
    
    action_title "MAKING";
    echo

    action; line "Preparing the bundle file for ${reponame}";
    cd "${source}/${reponame}/${reponame}".git/;
    git bundle create "${reponame}".bundle --all >> log 2>&1;

    action; line "Moving the bundle file for ${reponame}";
    mv "${reponame}".bundle ../;
    
    cd "${dir}"
  done < ${repo_list}

  echo
  sep;
  echo
  info; line "Finished processing your repositories. \c"; sleep 1; line "Moving on to archiving...";
  sleep 5s;
  clear
}

archive() {
  # Archive repos
  # -----------------------------------------------
  
  echo
  sep
  echo
  action_title "ARCHIVING";
  echo
  
  cd "${source}"  

  action; line "Making tar files. \c";

  for dir in */
  do
    base=$(basename "$dir")
    tar -czf "${base}_${cdate}.tar.gz" "$dir"
  done
  sleep 2s;
  line "Finished.";
  sleep 1s;
  echo
  sep
  echo
  
}

copy_archive(){
  # Copy archive files to output folder
  # -----------------------------------------------

  action_title "MOVING FILES";
  echo
  
  action; line "Moving all of the archived tar files. \c";
  mv *.tar.gz ${output}
  sleep 2s;
  line "Finished.";
  echo
  sep
  echo
  sleep 1s;
}


# Cleanup
# -----------------------------------------------

cleanup (){
  filelines="$(cat $repo_list)"

  action_title "CLEANUP";
  echo

  for line in $filelines; do
    suffix=".git"
    pre="${line##*/}"
    pre=${pre%"${suffix}"}
    f="${output}/${pre}_${cdate}.tar.gz"
    if [ ! -f "$f" ]; then
      sep
      echo
      indent; echo -e "WARNING: FILE DOES NOT EXIST!"
      echo
      indent; echo -e "${pre}.tar.gz should have been automatically created in"
      indent; echo -e "${f},"
      indent; echo -e "but for some reason it wasn't."
      indent; echo
      indent; echo -e "Check the source directory and try to run the archive operation manually:"
      indent; echo -e "tar -czf $(echo "${pre}").tar.gz $(echo "${output}/")"
      echo
      sep
    fi
  done

  action; line "Removing the source repo folders. \c";  
  cd ${source} && rm -rf * && cd ../;
  sleep 2s;
  line "Finished.";
  echo
  sep
  echo
  sleep 3s;
  clear
}

finished_msg() {  
  echo
  sep
  echo
  action_title "FINISHED";
  echo
  
  info; line "Your archives are ready!"
  echo
  line_i "You can find them in \c"; cmd_inline_noprompt "${output}/";
  echo
  sep;
  echo
  sleep 3;
}

run() {
  titleblock
  check_ex
  prompt_continue
  clear
  repo_list_empty_check
  github_clone
  archive
  copy_archive
  cleanup
  finished_msg
}
