import os
import socket

from kitty.constants import version
from kitty.fast_data_types import Screen
from kitty.tab_bar import (DrawData, TabBarData, ExtraData,
                           draw_tab_with_powerline)
from kitty.types import run_once

@run_once
def replacements():
    hostname = socket.gethostname()
    user_home = os.environ['USER'] + '@' + hostname
    root_home = 'root@' + hostname
    prog_status = 'tab.program_status'
    prog_status = (
        (prog_status, prog_status) if version >= (0, 50, 0) else ("''", '0')
    )
    return {'user_home': (user_home, str(len(user_home))),
            'root_home': (root_home, str(len(root_home))),
            'prog_status': prog_status}

def apply_replacements(template, repls):
    return (
        template.replace('$USERHOME_LEN', repls['user_home'][1])
                .replace('$USERHOME', repls['user_home'][0])
                .replace('$ROOTHOME_LEN', repls['root_home'][1])
                .replace('$ROOTHOME', repls['root_home'][0])
                .replace('$PROGSTATUS_CHK', repls['prog_status'][1])
                .replace('$PROGSTATUS', repls['prog_status'][0])
    )

def draw_tab(
    draw_data: DrawData, screen: Screen, tab: TabBarData,
    before: int, max_title_length: int, index: int, is_last: bool,
    extra_data: ExtraData,
) -> int:
    repls = replacements()
    new_title_template = apply_replacements(
        draw_data.title_template, repls
    )
    new_active_title_template = apply_replacements(
        draw_data.active_title_template, repls
    )
    new_draw_data = draw_data._replace(
        title_template = new_title_template,
        active_title_template = new_active_title_template
    )
    return draw_tab_with_powerline(
        new_draw_data, screen, tab, before, max_title_length, index,
        is_last, extra_data
    )

