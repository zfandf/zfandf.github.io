<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>读单词</title>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <link rel="icon" href="/static/images/favicon.ico" type="image/x-icon" />
    <link type="text/css" rel="stylesheet" href="/static/css/style.css"/>
    <!--<script type="text/javascript" src="static/js/js&f=jquery-1.7.2.min.js,tr.base.min.js,res.common.min.js,res.ringing.min.js,res.searchbox.js-v=10002"></script>-->
    <script type="text/javascript">
        var currentPageImagesPath = "static/";
        currentPageImagesPath = location.protocol == "http:" ? currentPageImagesPath : "";
    </script>
    <!--[if lt IE 7]>
    <link href="/static/css/ie6.css" rel="stylesheet" type="text/css"/>
    <![endif]-->
<body>

<div id="wrapper">
    <div class="choosenav">
        <span class="ringing-ico"></span>
        <h3>List</h3>
    </div>

    <div class="ringing">
        <ul>
{ringing_list}
        </ul>
    </div>
    <!--ringing end-->

    <!--page start-->
    <div class="page">
        <div class="pagearea">
            <a class="onepage" href="{onepage}">第一页</a>
            <a class="abovepage" href="{abovepage}">上一页</a>
            {page_list}
            <a class="nextpage" href="{nextpage}"></a>
            <a class="lastpage" href="{lastpage}">最末页</a>
        </div>
    </div>
    <!--page end-->
    <div class="clear"></div>

    <div class="backtoTop" title="返回顶部" style="right: 0px; display: block;">返回顶部</div>
</div>

<script type="text/javascript">
    var eAudio, eCurrent;

    window.onload = function() {
        eAudio = document.createElement('audio');
        eAudio.pos = -1;
        document.body.appendChild(eAudio);

        initAudio(eAudio);

        var eBtns = document.getElementsByClassName('btnBroad');
        for (var i = 0; i < eBtns.length; i++) {
            var elm = eBtns[i].querySelector('a');
            elm.onclick = function() {
                console.log('click');
                player(this);
            };
        }
    };

    function stop() {
        var eSign = eCurrent.parentElement.parentElement.querySelector('.listenGif');
        eAudio.pause();
        eSign.style.display = 'none';
        eCurrent.className = '';
    }

    function player (elm) {
        if (elm == eCurrent && eCurrent.className == 'on') {
            stop();
            return;
        } else if (eCurrent != undefined) {
            stop();
        }

        eCurrent = elm;
        var eSign = eCurrent.parentElement.parentElement.querySelector('.listenGif');
        var aud_url = eCurrent.getAttribute('aud_url');
        eAudio.src = aud_url;
        console.log(aud_url);
        eAudio.play();
        eCurrent.className = 'on';
        eSign.style.display = 'inline';
    }


    function initAudio(aud) {

        try {
            var AudioCxt = new (window.AudioContext || window.webkitAudioContext)();
            var source = AudioCxt.createMediaElementSource(eAudio);
            var gainNode = AudioCxt.createGain();
            source.connect(gainNode);
            gainNode.connect(AudioCxt.destination);
        } catch (e) {
            console.log('AudioContext error');
        }

        aud.addEventListener('progress', function(evt) {
        });

        aud.addEventListener('timeupdate', function(evt) {
            var percentPlayed = Math.round(aud.currentTime / aud.duration * 100);
            console.log('play process: ' + percentPlayed);
        });

        aud.addEventListener('canplay', function(evt) {
            console.log('canplay');
        });

        aud.addEventListener('ended', function(evt) {
            stop();
            console.log('ended');
        });
    }

</script>
</body>
</html>
