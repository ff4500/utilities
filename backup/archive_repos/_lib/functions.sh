#!/usr/bin/env bash

ind="  "
sep_ll="56"

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

cmd(){
  indent; indent; echo -e "${bg_darkgrey_02}   ${reset}"
  indent; indent; echo -e "${bg_darkgrey_02}${ui_text_cmd} > ${reset}${fg_lightgrey} \$ ${reset}\c"
  echo -e "${fg_lightgrey}$1${reset}"
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
  indent; indent; echo -e "${bg_darkgrey_02}   ${reset} \c"; echo -e $1
}

alert_line(){
  indent; indent; echo -e "${bg_darkgrey_02}${fg_red} ! ${reset} \c"; echo -e "${fg_red}$1${reset}"
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
    alert_line "Base dir doesn't exist."; line_2 "Making it now."
    cmd "mkdir ${base_dir}"
    echo; sleep 1
    mkdir ${base_dir}
  else
    info; line "Base dir exists at:"; line_2 "${ui_text_cmd}${base_dir}${reset}"
    echo
  fi

  if [ ! -d "${source}" ]; then
    alert_line "Source dir doesn't exist."; line_2 "Making it now."
    cmd "mkdir ${source}"
    echo; sleep 1
    mkdir ${source}
  else
    info; line "Source dir exists at:"; line_2 "${ui_text_cmd}${source}${reset}"
    echo
  fi

  if [ ! -d "${output}" ]; then
    alert_line "Output dir doesn't exist."; line_2 "Making it now."
    cmd "mkdir ${output}"
    echo; sleep 1
    mkdir ${output}
  else
    info; line "Output dir exists at:"; line_2 "${ui_text_cmd}${output}${reset}"
    echo
  fi

  if [ ! -f "${repo_list}" ]; then
    alert_line "A repository list doesn't exist."; line_2 "Making the ${bg_aqua} _src ${reset} dir and an empty list now."
    cmd "touch ${repo_list}"
    echo; sleep 1
    mkdir ${base_dir}/_src && touch ${repo_list}
  else
    info; line "A repository list exists at:"; line_2 "${ui_text_cmd}${repo_list}${reset}"
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
    info; line "You said YES";
    sleep 1s;
    line_2 "Moving on...";
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
    sleep 2s;
    exit 0;
  fi
}

# Check if repo_list.txt is empty

repo_list_empty_check(){
  echo
  sep
  echo

  sec_hl "Checking for repositories in your list:"

  if [ ! -s "${repo_list}" ]; then
    alert_line "There aren't any repos defined in your list yet."; line_2 "Add them to ${fg_aqua}${repo_list}${reset}"
    exit 0;
  else
    info; line "Here's what you have in you list now:"
    echo -e "${fg_aqua}"
    cat ${repo_list} | sed 's/^/    /g'
    echo -e "${reset}"
    user_prompt_continue
  fi
}

# # Clone everything in repo_list to source folder
# # -----------------------------------------------
#
# while read line; do
#   #echo -e "git clone $line";
#   git -C $source/ clone --quiet $line
# done < ${repo_list}
#
#
# # Archive repos
# # -----------------------------------------------
#
# cd ${source}
#
# for dir in */
# do
#   base=$(basename "$dir")
#   tar -czf "${base}.tar.gz" "$dir"
# done
#
#
# # Copy archive files to output folder
# # -----------------------------------------------
#
# mv *.tar.gz ${output}


# Cleanup
# -----------------------------------------------

zzz (){
  filelines="$(cat $repo_list)"
  for line in $filelines; do
    suffix=".git"
    pre="${line##*/}"
    pre=${pre%"${suffix}"}
    f="${output}/${pre}.tar.gz"
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
    # else
    #   echo -e "It's there! \c"
    #   echo -e "${f}"
    fi
  done
}

#zzz

run() {
  titleblock
  check_ex
  prompt_continue
  clear
  repo_list_empty_check
  echo -e "yay!"
}
