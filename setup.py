from setuptools import setup, find_packages

def get_version():
    return '0.5.0'

setup(
    name='biovis-rbased-plugins',
    version=get_version(),
    description='A set of R based plugins for biovis-report to draw interactive plots.',
    keywords='biovis-plugin',
    url='https://github.com/biovis-report/biovis-rbased-plugins',
    author='Jingcheng Yang',
    author_email='yjcyxky@163.com',
    license='MIT',
    python_requires='>=3.7',
    include_package_data=True,
    install_requires=[
        'biovis-report~=0.5'
    ],
    classifiers=[
        'Development Status :: 4 - Beta',
        'Intended Audience :: Developers',
        'Intended Audience :: Information Technology',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python',
        'Programming Language :: Python :: 3 :: Only',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
        'Programming Language :: Python :: 3.10'
    ],
    packages=find_packages(),
    entry_points={
        'biovis.plugins': [
            'barplot-r = barplot.barplot:BarPlotRPlugin',
            'boxplot-r = boxplot.boxplot:BoxPlotRPlugin',
            'corrplot-r = corrplot.corrplot:CorrPlotRPlugin',
            'density-plot-r = density_plot.density_plot:DensityPlotRPlugin',
            'grouped-boxplot-r = grouped_boxplot.grouped_boxplot:GroupedBoxPlotRPlugin',
            'heatmap-r = heatmap.heatmap:HeatmapRPlugin',
            'heatmap-d3-r = heatmap_d3.heatmap:HeatmapD3RPlugin',
            'lineplot-r = lineplot.lineplot:LinePlotRPlugin',
            'lollipop-plot-r = lollipop_plot.lollipop_plot:LollipopPlotRPlugin',
            'rocket-plot-r = rocket_plot.rocket_plot:RocketPlotRPlugin',
            'scatter-plot-r = scatter_plot.scatter_plot:ScatterPlotRPlugin',
            'stack-barplot-r = stack_barplot.stack_barplot:StackBarPlotRPlugin',
            'upset-r = upset.upset:UpsetRPlugin',
            'violin-plot-r = violin_plot.violin_plot:ViolinPlotRPlugin'
        ]
    }
)
