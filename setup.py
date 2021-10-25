from setuptools import setup, find_packages
from boxplot_r.version import get_version


setup(
    name='boxplot-r',
    version=get_version(),
    description='An biovis-report plugin to draw an interactive boxplot.',
    long_description='The boxplot plugin will draw an interactive boxplot by using rlang library.',
    keywords='boxplot-r,biovis-plugin',
    url='https://github.com/biovis-report/boxplot-r/',
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
            'boxplot-r = boxplot_r.boxplot:BoxplotRPlugin'
        ]
    }
)
