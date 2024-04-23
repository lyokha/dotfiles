import os
import socket

from kitty.fast_data_types import Screen
from kitty.tab_bar import (DrawData, TabBarData, ExtraData,
                           draw_tab_with_powerline)

def draw_tab(
    draw_data: DrawData, screen: Screen, tab: TabBarData,
    before: int, max_title_length: int, index: int, is_last: bool,
    extra_data: ExtraData,
) -> int:
    hostname = socket.gethostname()
    user_home = os.environ['USER'] + '@' + hostname
    user_home_len = str(len(user_home))
    root_home = 'root@' + hostname
    root_home_len = str(len(root_home))
    title_template = draw_data.title_template
    new_title_template = (
            title_template.replace('$USERHOME_LEN', user_home_len)
                          .replace('$USERHOME', user_home)
                          .replace('$ROOTHOME_LEN', root_home_len)
                          .replace('$ROOTHOME', root_home)
    )
    active_title_template = draw_data.active_title_template
    new_active_title_template = (
            active_title_template.replace('$USERHOME_LEN', user_home_len)
                                 .replace('$USERHOME', user_home)
                                 .replace('$ROOTHOME_LEN', root_home_len)
                                 .replace('$ROOTHOME', root_home)
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

