#!/usr/bin/env bash

# Indention - for reuse
# -----------------------------------------------
ind="  "
indent() {
  printf "${ind}"
}

# Seperators
# -----------------------------------------------
sep() {
  local ch="-"
  local sep_line="$(printf '%*s' "56" | tr ' ' "$ch")"
  echo -e "${ind}${fg_darkgrey_01}${sep_line}${reset}${ind}"
  #echo -e "-----------------------------------------------------------------------------"
}

aaa() {
  echo -e "${fg_darkgrey_01}  --------------------------------------------------------  ${reset}"
}

info(){
  indent; indent; echo -e "${bg_darkgrey_02}${ui_text_info} i ${reset} \c"
}

cmd(){
  indent; indent; echo -e "${bg_darkgrey_02}   ${reset}"
  indent; indent; echo -e "${bg_darkgrey_02}${ui_text_cmd} > ${reset}${fg_darkgrey_01} \$ ${reset}\c"
}

sec_hl(){
  indent; indent; echo -e "${bg_lightpurple} $1 ${reset}";
  echo
}

line(){
  echo -e $1
}

line_2(){
  indent; indent; echo -e "${bg_darkgrey_02}   ${reset} \c"; echo -e $1
}

# Check directory/file existence
# -----------------------------------------------

check_ex(){
  echo
  sep
  echo

  sec_hl "Checking for required files/folders:"

  if [ ! -d "${base_dir}" ]; then
    info; line "${fg_lightgrey}Base dir${reset} doesn't exist."; line_2 "Making it now."
    cmd; line "${fg_lightgrey}mkdir ${base_dir}${reset}"
    echo; sleep 1
    mkdir ${base_dir}
  else
    info; line "Base dir exists at ${ui_text_cmd}${base_dir}${reset}"
    echo
  fi

  if [ ! -d "${source}" ]; then
    info; line "${fg_lightgrey}Source dir${reset} doesn't exist."; line_2 "Making it now."
    cmd; line "${fg_lightgrey}mkdir ${source}${reset}"
    echo; sleep 1
    mkdir ${source}
  else
    info; line "Source dir exists at ${ui_text_cmd}${source}${reset}"
    echo
  fi

  if [ ! -d "${output}" ]; then
    info; line "${fg_lightgrey}Output dir${reset} doesn't exist."; line_2 "Making it now."
    cmd; line "${fg_lightgrey}mkdir ${output}${reset}"
    echo; sleep 1
    mkdir ${output}
  else
    info; line "Output dir exists at ${ui_text_cmd}${output}${reset}"
    echo
  fi

  if [ ! -f "${repo_list}" ]; then
    info; line "A ${fg_lightgrey}repository list${reset} doesn't exist."; line_2 "Making the ${ui_text_cmd}_src${reset} dir and an empty list now."
    cmd; line "${fg_lightgrey}touch ${repo_list}${reset}"
    echo; sleep 1
    mkdir ${base_dir}/_src && touch ${repo_list}
  else
    info; line "A repository list exists at ${ui_text_cmd}${repo_list}${reset}"
    echo
  fi

  echo
  sep
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
  check_ex
  echo
  sep
  indent; indent; echo "Yay"
  sep
  echo
  aaa
  indent; indent; echo "YAY!"
  aaa
  echo
}
