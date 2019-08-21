#!/usr/bin/env bash

indent() {
  local ind="  "
  printf "${ind}"
}

sep() {
  local ch="-"
  local sep_line="$(printf '%*s' "60" | tr ' ' "$ch")"
  echo -e "${indent}${grey}${sep_line}${reset}${indent}"
  #echo -e "-----------------------------------------------------------------------------"
}


# Check directory existence
# -----------------------------------------------

# if [ ! -d "${source}" ]; then
#   mkdir ${source}
# fi
#
# if [ ! -d "${output}" ]; then
#   mkdir ${output}
# fi
#
#
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
  sep
  indent; echo "Yay"
  sep
}