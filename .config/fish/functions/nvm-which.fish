function nvm-which -d "locate node version installed by nvm.fish"
  argparse -i i/install -- $argv

  set -l v_installed
  set -l v $argv[1]

  test -n "$v" || begin
    echo version required
    return 1
  end

  #load nvm and it's utility functions
  type nvm >/dev/null || nvm --help >/dev/null

  _nvm_list | string match -e -r (_nvm_version_match $v) | read v_installed __

  if test -z "$v_installed" && set -q _flag_install
    #install if asked
    nvm install $v >/dev/null 2>&1
    #locate newly installed version
    _nvm_list | string match -e -r (_nvm_version_match $v) | read v_installed __
  end

  test -n "$v_installed" || return 1

  #print nvm path
  echo $nvm_data/$v_installed
end
