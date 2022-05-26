# -*- coding:utf-8 -*-
from __future__ import unicode_literals

import os
from biovis_media_extension.plugin import BasePlugin


class LinePlotRPlugin(BasePlugin):
    """
    LinePlotRPlugin plugin for next service engine.

    :Example:
    @lineplot-r()
    """
    plugin_name = 'lineplot-r'
    plugin_dir = os.path.dirname(os.path.abspath(__file__))
    is_server = True

    def __init__(self, *args, **kwargs):
        super(LinePlotRPlugin, self).__init__(*args, **kwargs)

    def check_plugin_args(self, **kwargs):
        pass
