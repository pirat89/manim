FROM fedora:33

# update the image before we start to do anythign else..
# install rpm-fusion* - needed for ffmpeg and friends..
# install all needed deps so at least the examples are working right
RUN dnf update -y \
    && dnf install -y \
        https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
    && dnf install -y \
        "cairo-gobject" \
        "cairomm" \
        "ffmpeg" \
        "gcc" \
        "git" \
        "python3-cairo" \
        "python3-cairo-devel" \
        "python3-wheel" \
        "sox" \
        "texlive-dvisvgm" \
        "texlive-latex" \
        "tex(standalone.cls)" \
        "tex(preview.sty)" \
        "tex(dsfont.sty)" \
        "tex(relsize.sty)" \
        "tex(calligra.sty)" \
        "tex(physics.sty)"
COPY . /manim
RUN cd /manim \
    && python setup.py sdist \
    && python -m pip install dist/manimlib*
#ENTRYPOINT ["/bin/bash"]
ENTRYPOINT ["manim", "--media_dir", "/output"]
