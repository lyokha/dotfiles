import os
import socket

from kitty.fast_data_types import Screen
from kitty.tab_bar import (DrawData, TabBarData, ExtraData,
                           draw_tab_with_powerline)
from kitty.types import run_once

@run_once
def replacements():
    hostname = socket.gethostname()
    user_home = os.environ['USER'] + '@' + hostname
    root_home = 'root@' + hostname
    return {'user_home': (user_home, str(len(user_home))),
            'root_home': (root_home, str(len(root_home)))}

def draw_tab(
    draw_data: DrawData, screen: Screen, tab: TabBarData,
    before: int, max_title_length: int, index: int, is_last: bool,
    extra_data: ExtraData,
) -> int:
    repls = replacements()
    title_template = draw_data.title_template
    new_title_template = (
            title_template.replace('$USERHOME_LEN', repls['user_home'][1])
                          .replace('$USERHOME', repls['user_home'][0])
                          .replace('$ROOTHOME_LEN', repls['root_home'][1])
                          .replace('$ROOTHOME', repls['root_home'][0])
    )
    active_title_template = draw_data.active_title_template
    new_active_title_template = (
            active_title_template
                          .replace('$USERHOME_LEN', repls['user_home'][1])
                          .replace('$USERHOME', repls['user_home'][0])
                          .replace('$ROOTHOME_LEN', repls['root_home'][1])
                          .replace('$ROOTHOME', repls['root_home'][0])
    )
    new_draw_data = draw_data._replace(
            title_template = new_title_template,
            active_title_template = new_active_title_template
    )
    end = draw_tab_with_powerline(
            new_draw_data, screen, tab, before, max_title_length, index,
            is_last, extra_data
    )
    return end

