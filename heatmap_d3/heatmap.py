# -*- coding:utf-8 -*-
from __future__ import unicode_literals

import os
from biovis_media_extension.plugin import BasePlugin


class HeatmapD3RPlugin(BasePlugin):
    """
    Heatmap plugin for biovis_media_extension.

    :Example:
    @heatmap-d3-r()
    """
    plugin_name = 'heatmap-d3-r'
    plugin_dir = os.path.dirname(os.path.abspath(__file__))
    is_server = True

    def __init__(self, *args, **kwargs):
        super(HeatmapD3RPlugin, self).__init__(*args, **kwargs)

    def check_plugin_args(self, **kwargs):
        pass
