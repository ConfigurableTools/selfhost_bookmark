<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>主页</title>
    <style>
        body{
            backgroud-color: #5A5475;
        }
        table {
            width: 90%;
            table-layout: fixed;
        }
        th, td{
            text-align: left;
        }
        input:invalid {
            border: 2px dashed red;
        }
        input:valid {
            border: 2px solid black;
        }
    </style>
</head>
<body>
    <table>
        <tr id="new_item">
            <th style="width: 30%;">标题</th>
            <th style="width: 10%;">访问次数</th>
            <th style="width: 50%;">地址</th>
            <th style="width: 10%;">操作</th>
        </tr>
        % if len(bookmarks) == 0:
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td><button onclick="new_item()" >新增</button></td>
            </tr>
        % end 
        % i = 0
        % for bookmark in bookmarks:
            <tr>
                <td>{{bookmark["title"]}}</td>
                <td id={{bookmark["id"]}}>{{bookmark["visit_times"]}}</td>
                <td><a href="{{bookmark['url']}}" target="_blank" onclick="count_visit({{bookmark["id"]}})">{{bookmark["url"]}}</a></td>
                <td>
                    <button onclick="delete_item({{bookmark["id"]}})">删除</button>
                    % if i == 0:
                        <button onclick="new_item()" >新增</button>
                    % i += 1
                    % end
                </td>
            </tr>
        % end
    </table>
</body>


<script type="text/javascript">
    function delete_item(id){
        if(confirm("确定删除？")){
            var url = "http://"+ window.location.host +"/delete_bookmark";
            var httpRequest = new XMLHttpRequest();
            httpRequest.open('POST', url, true);
            httpRequest.setRequestHeader("Content-type", "application/text");
            httpRequest.send(id);

            httpRequest.onreadystatechange = function () {
            if (httpRequest.readyState == 4 && httpRequest.status == 200) {
                var res = httpRequest.responseText;
                if (res == "success"){
                    document.getElementById(id).parentElement.remove()
                }
                }
            };
        }
    }
    function count_visit(id){
        var url = "http://"+ window.location.host +"/count_visit";
        var httpRequest = new XMLHttpRequest();
            httpRequest.open('POST', url, true);
            httpRequest.setRequestHeader("Content-type", "application/text");
            httpRequest.send(id);

            httpRequest.onreadystatechange = function () {
            if (httpRequest.readyState == 4 && httpRequest.status == 200) {
                var res = httpRequest.responseText;
                console.log(res)
                if (res == "success"){
                    document.getElementById(id).innerHTML = parseInt(document.getElementById(id).innerHTML) + 1 
                }
            }
        };
    }

    function new_item(){
        uniq_id = new Date().getTime();
        console.log(uniq_id)
        document.getElementById("new_item").outerHTML  += "<tr>" + 
            "<td><input type='text' id='title"+ uniq_id + "'></td>" +
            "<td></td>" + 
            "<td><input type='text' id='url"+uniq_id+"'></td>" + 
            "<td><button id="+uniq_id+" onclick='submit_item("+uniq_id+")' >提交</button></td>" +
            "</tr>" 
    }

    function submit_item(uniq_id){
        
        var _title = document.getElementById("title"+uniq_id).value
        var _url = document.getElementById("url"+uniq_id).value
        if (_title == '' || _title == undefined || _title == null){
            document.getElementById("title"+uniq_id).setCustomValidity("不能为空！");
            return;
        } 
        if (_url == '' || _url == undefined || _url == null){
            document.getElementById("url"+uniq_id).setCustomValidity("不能为空！");
            return;
        }

        var url = "http://"+ window.location.host +"/submit_item";
        var httpRequest = new XMLHttpRequest();
            httpRequest.open('POST', url, true);
            httpRequest.setRequestHeader("Content-type", "application/text");
            httpRequest.send("["+ _title + "]("+ _url + ")");

            httpRequest.onreadystatechange = function () {
            if (httpRequest.readyState == 4 && httpRequest.status == 200) {
                var res = httpRequest.responseText;
                console.log(res)
                if (res == "success"){
                    document.getElementById("title"+uniq_id).replaceWith(_title)
                    document.getElementById("url"+uniq_id).replaceWith(_url)
                    document.getElementById(uniq_id).remove()
                }
                }
            };
    }
</script>

</html>