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
  local sep_line="$(printf '%*s' "60" | tr ' ' "$ch")"
  echo -e "${indent}${grey}${sep_line}${reset}${indent}"
  #echo -e "-----------------------------------------------------------------------------"
}

aaa() {
  echo -e "${fg_darkgrey_01}  --------------------------------------------------------  ${reset}"
}

# Check directory existence
# -----------------------------------------------
aaa
echo

if [ ! -d "${base_dir}" ]; then
  indent; indent; echo -e "Base dir doesn't exist. Making it now."
  indent; indent; echo -e "> mkdir ${base_dir}"
  echo
  #mkdir ${source}
else
  echo -e "Base dir exists at ${base_dir}"
fi

if [ ! -d "${source}" ]; then
  indent; indent; echo -e "Source dir doesn't exist. Making it now."
  indent; indent; echo -e "> mkdir ${source}"
  echo
  #mkdir ${source}
else
  echo -e "Source dir exists at ${source}"
fi

if [ ! -d "${output}" ]; then
  indent; indent; echo -e "Output dir doesn't exist. Making it now."
  indent; indent; echo -e "> mkdir ${output}"
  #mkdir ${output}
else
  echo -e "Output dir exists at ${output}"
fi

echo
aaa

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
  echo
  sep
  indent; echo "Yay"
  sep
  echo
  aaa
  indent; indent; echo "YAY!"
  aaa
  echo
}
