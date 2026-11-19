import os
import sys
import socket

from kitty.boss import get_boss
from kitty.constants import version
from kitty.fast_data_types import (Screen, add_timer, is_tab_bar_visible,
                                   remove_timer, wakeup_main_loop)
from kitty.tab_bar import (DrawData, TabAccessor, TabBarData, ExtraData,
                           draw_tab_with_powerline)
from kitty.types import run_once

#  _WORKING_FRAMES = ('󰪞', '󰪟', '󰪠', '󰪡', '󰪢', '󰪣', '󰪤', '󰪥')
_WORKING_FRAMES = ('', '', '', '', '', '')
_WORKING_SYMBOL = '\uf110'
_FRAME_INTERVAL = 0.1
_frame_idx = 0


def _animation_timer(timer_id: int | None) -> None:
    from kitty.program_status import combined_status_symbol

    global _frame_idx
    boss = get_boss()
    tab_managers = boss.all_tab_managers if boss is not None else ()
    animated_tab_managers = [
        tm for tm in tab_managers
        if is_tab_bar_visible(tm.os_window_id)
        and any(
            _WORKING_SYMBOL in
                combined_status_symbol(w.program_status for w in tab)
            for tab in tm.tabs_to_be_shown_in_tab_bar
        )
    ]
    if not animated_tab_managers:
        _stop_timer()
        return
    _frame_idx = (_frame_idx + 1) % len(_WORKING_FRAMES)
    for tm in animated_tab_managers:
        tm.mark_tab_bar_dirty()


def _stop_timer() -> None:
    timer_id = getattr(sys, '_kitty_spinner_timer_id', None)
    if timer_id is not None:
        remove_timer(timer_id)
        del sys._kitty_spinner_timer_id


@run_once
def _clear_previous_timer() -> None:
    # A config reload can leave the previous module's timer registered.
    _stop_timer()


@run_once
def _replacements():
    hostname = socket.gethostname()
    user_home = os.environ['USER'] + '@' + hostname
    root_home = 'root@' + hostname
    if version >= (0, 51, 0):
        prog_status = (
            f"tab.program_status.replace('{_WORKING_SYMBOL}', '$ANIM_FRAME')",
            'tab.program_status',
        )
    else:
        prog_status = ("''", '0')
    return {
        'user_home': (user_home, str(len(user_home))),
        'root_home': (root_home, str(len(root_home))),
        'prog_status': prog_status,
    }


def _apply_replacements(template, repls, frame=''):
    u_str, u_len = repls['user_home']
    r_str, r_len = repls['root_home']
    p_str, p_chk = repls['prog_status']
    return (
        template.replace('$USERHOME_LEN', u_len)
                .replace('$USERHOME', u_str)
                .replace('$ROOTHOME_LEN', r_len)
                .replace('$ROOTHOME', r_str)
                .replace('$PROGSTATUS_CHK', p_chk)
                .replace('$PROGSTATUS', p_str)
                .replace('$ANIM_FRAME', frame)
    )


def draw_tab(
    draw_data: DrawData, screen: Screen, tab: TabBarData,
    before: int, max_title_length: int, index: int, is_last: bool,
    extra_data: ExtraData,
) -> int:
    _clear_previous_timer()
    if (
        version >= (0, 51, 0)
        and not hasattr(sys, '_kitty_spinner_timer_id')
        and _WORKING_SYMBOL in TabAccessor(tab.tab_id).program_status
    ):
        sys._kitty_spinner_timer_id = add_timer(
            _animation_timer, _FRAME_INTERVAL, True
        )
    repls = _replacements()
    frame = _WORKING_FRAMES[_frame_idx]
    new_title_template = _apply_replacements(
        draw_data.title_template, repls, frame
    )
    new_active_title_template = _apply_replacements(
        draw_data.active_title_template, repls, frame
    )
    new_draw_data = draw_data._replace(
        title_template = new_title_template,
        active_title_template = new_active_title_template
    )
    return draw_tab_with_powerline(
        new_draw_data, screen, tab, before, max_title_length, index,
        is_last, extra_data
    )

