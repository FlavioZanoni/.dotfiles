# Match the Nvim Dark palette used by Ghostty and Kitty.
if status is-interactive
    set -g fish_color_normal e0e2ea
    set -g fish_color_command a6dbff
    set -g fish_color_keyword ffcaff
    set -g fish_color_quote b3f6c0
    set -g fish_color_redirection 8cf8f7
    set -g fish_color_end fce094
    set -g fish_color_error ffc0b9
    set -g fish_color_param e0e2ea
    set -g fish_color_comment 9b9ea4
    set -g fish_color_operator 8cf8f7
    set -g fish_color_escape ffcaff
    set -g fish_color_autosuggestion 4f5258
    set -g fish_color_search_match --background=282b32
    set -g fish_color_selection --background=282b32
    set -g fish_pager_color_prefix a6dbff
    set -g fish_pager_color_completion e0e2ea
    set -g fish_pager_color_description 9b9ea4
    set -g fish_pager_color_selected_background --background=282b32

    # Keep the existing Tide prompt layout; soften its colours to match.
    set -g tide_character_color b3f6c0
    set -g tide_character_color_failure ffc0b9
    set -g tide_pwd_color_anchors a6dbff
    set -g tide_pwd_color_dirs a6dbff
    set -g tide_pwd_color_truncated_dirs 9b9ea4
    set -g tide_git_color_branch b3f6c0
    set -g tide_git_color_dirty fce094
    set -g tide_git_color_staged fce094
    set -g tide_git_color_conflicted ffc0b9
    set -g tide_git_color_operation ffc0b9
    set -g tide_git_color_untracked a6dbff
    set -g tide_git_color_upstream b3f6c0
    set -g tide_git_color_stash b3f6c0
end
