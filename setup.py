from setuptools import setup, find_packages

def get_version():
    return '0.1.0'

setup(
    name='biovis-base-plugins',
    version=get_version(),
    description='A set of base plugins for biovis-report to draw interactive plots.',
    keywords='biovis-plugin',
    url='https://github.com/biovis-report/biovis-base-plugins',
    author='Jingcheng Yang',
    author_email='yjcyxky@163.com',
    license='MIT',
    python_requires='>=3.4',
    include_package_data=True,
    install_requires=[
        'biovis-media-extension>=0.1.0',
        'biovis-report>=0.4.0'
    ],
    classifiers=[
        'Development Status :: 4 - Beta',
        'Intended Audience :: Developers',
        'Intended Audience :: Information Technology',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python',
        'Programming Language :: Python :: 3 :: Only',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7'
    ],
    packages=find_packages(),
    entry_points={
        'biovis.plugins': [
            'boxplot-r = boxplot_r.boxplot:BoxplotRPlugin',
            'corrplot-r = corrplot_r.corrplot_r:CorrPlotRPlugin',
            'data-table-js = datatable_js.datatable:DataTableJSPlugin',
            'density-plot = density_plot.density_plot:DensityPlotPlugin',
            'group-boxplot = group_boxplot.group_boxplot:GroupBoxPlotPlugin',
            'heatmap-d3 = heatmap_d3.heatmap:HeatmapD3Plugin',
            'heatmap-r = heatmap_r.heatmap:HeatmapRPlugin',
            'multiqc = multiqc.multiqc:MultiqcPlugin',
            'pivot-table-js = pivot_table_js.pivot_table:PivotTableJSPlugin',
            'rocket-plot-r = rocket_plot_r.rocket_plot:RocketPlotRPlugin',
            'scatter-plot = scatter_plot.scatter_plot:ScatterPlotPlugin',
            'stack-barplot-r = stack_barplot_r.stack_barplot:StackBarPlotPlugin',
            'tabulator = tabulator.tabulator:Tabulator',
            'upset-r = upset_r.upset:UpsetRPlugin',
            'violin-plot-r = violin_plot_r.violin_plot:ViolinPlotRPlugin'
        ]
    }
)
