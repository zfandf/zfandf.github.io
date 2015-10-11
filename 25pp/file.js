var fs = require('fs'),
    stdin = process.stdin,
    music_path = process.cwd() + '/music/';

var stats = [];

fs.readdir(music_path, function(err, files) {
    if (!files.length) {
        return console.log(' \033[31m No files to show!\033[39m\n');
    }

    function file(i) {
        var filename = files[i];

        if (filename.indexOf('.mp3') !== -1) {
            stats.push({
                name: filename,
                path: 'music/' + encodeURIComponent(filename)
            });
        }

        i++;
        if (i == files.length) {
            stdin.pause();
        } else {
            file(i);
        }
    }

    file(0);

    var count = 4;
    var page_number = 0;
    var page_ringing = {};

    var index_tpl = fs.readFileSync('index.tpl','utf8'),
        ringing_tpl = fs.readFileSync('ringing.tpl','utf8');

    for (var idx = 0; idx < stats.length; idx++) {
        var str = ringing_tpl.replace('{name}', stats[idx].name)
                            .replace('{path}', stats[idx].path);

        if (idx%count == 0) {
            page_number++;
            page_ringing[page_number] = str;
        } else {
            page_ringing[page_number] += str;
        }
    }

    var onepage = '1.html',
        lastpage = page_number + '.html',
        abovepage = '1.html',
        nextpage = '1.html';

    if (page_number == 1) {
        var page_list = '<a href="1.html" class="current">1</a>';
        var data = index_tpl
                        .replace('{ringing_list}', page_ringing[1])
                        .replace('{onepage}', onepage)
                        .replace('{lastpage}', lastpage)
                        .replace('{abovepage}', abovepage)
                        .replace('{nextpage}', nextpage)
                        .replace('{page_list}', page_list);

        fs.writeFile('1.html', data, 'utf8');
    } else {
        for (var i = 1; i <= page_number; i++) {
            abovepage = (i == 1 ? 1 : i-1) + '.html';
            nextpage = (i == page_number ? page_number : i+1) + '.html';

            var page_list = '';

            for (var j = 1; j <= page_number; j++) {
                if (i == j) {
                    page_list += '<a href="' + j + '.html" class="current">' + j + '</a>';
                } else {
                    page_list += '<a href="' + j + '.html">' + j + '</a>';
                }
            }
            var data = index_tpl
                .replace('{ringing_list}', page_ringing[i])
                .replace('{onepage}', onepage)
                .replace('{lastpage}', lastpage)
                .replace('{abovepage}', abovepage)
                .replace('{nextpage}', nextpage)
                .replace('{page_list}', page_list);

            fs.writeFile(i + '.html', data, 'utf8');
        }

    }
});