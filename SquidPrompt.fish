# name: Squid Prompt
# author: ThatGeekyWeeb

function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -l normal (set_color normal)

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix '$('
    if contains -- $USER root toor
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '# - {'
    end

    # If we're running via SSH, change the host color.
    set -l color_host $fish_color_host
    if set -q SSH_TTY
        set color_host $fish_color_host_remote
    end

    # Write pipestatus
    set -l prompt_status (__fish_print_pipestatus "" "" "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)

    if [ -n "$type" ]
        set time (date +'%H:%M:%S')
    else
        set time "Now"
    end
    set exit "Exit Code:["
    if [ "$USER" = "root" ]
        echo -s (set_color $fish_color_user) "$USER " (set_color normal) - (set_color red) " $exit" "$prompt_status" (set_color red) "]" (set_color normal)" - " (set_color brpurple) "["(prompt_pwd)"] " "- Time: $time"
        echo -e (set_color normal) "$suffix"
    else
        echo -s (set_color 87afaf) " {" (set_color $fish_color_user) "$USER" (set_color 87afaf) "} " (set_color normal) - (set_color brpurple) " ["(prompt_pwd)"] " (set_color normal) - " $exit" "$prompt_status]"" - Time: $time"
        echo -e (set_color normal) "$suffix"
    end
end

function fish_right_prompt
    if [ $USER = "root" ]
        set -l normal (set_color normal)
        echo -n -s (set_color normal) "}"(battery)
    else
        set -l normal (set_color normal)
        echo -n -s (set_color normal) ")"(battery)
    end
end
