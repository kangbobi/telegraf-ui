from setuptools import setup, find_packages

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

with open("requirements.txt", "r", encoding="utf-8") as fh:
    requirements = [line.strip() for line in fh if line.strip() and not line.startswith("#")]

setup(
    name="telegraf_ui",
    version="1.0.0",
    author="kangbobi",
    author_email="devprogramming.bs@gmail.com",
    description="Manajemen konfigurasi Telegraf multi-host melalui antarmuka Frappe + SSH",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/kangbobi/telegraf_ui",
    packages=find_packages(),
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
        "Framework :: Frappe",
        "Topic :: System :: Monitoring",
        "Topic :: System :: Systems Administration",
    ],
    python_requires=">=3.8",
    install_requires=requirements,
    include_package_data=True,
    zip_safe=False,
    keywords="frappe, telegraf, monitoring, ssh, configuration",
    project_urls={
        "Bug Reports": "https://github.com/kangbobi/telegraf_ui/issues",
        "Source": "https://github.com/kangbobi/telegraf_ui",
        "Documentation": "https://github.com/kangbobi/telegraf_ui#readme",
    },
)
