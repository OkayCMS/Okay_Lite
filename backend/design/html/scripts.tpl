{capture name=tabs}
    <li>
        <a href="index.php?module=ThemeAdmin">Тема</a>
    </li>
    <li>
        <a href="index.php?module=TemplatesAdmin">Шаблоны</a>
    </li>
    <li>
        <a href="index.php?module=StylesAdmin">Стили</a>
    </li>
    <li class="active">
        <a href="index.php?module=ScriptsAdmin">Скрипты</a>
    </li>
    <li>
        <a href="index.php?module=ImagesAdmin">Изображения</a>
    </li>
    {if in_array('robots', $manager->permissions)}
        <li>
            <a href="index.php?module=RobotsAdmin">Robots.txt</a>
        </li>
    {/if}
{/capture}

{if $script_file}
    {$meta_title = "Скрипт $script_file" scope=parent}
{/if}

{* Подключаем редактор кода *}
<link rel="stylesheet" href="design/js/codemirror/lib/codemirror.css">
<link rel="stylesheet" href="design/js/codemirror/theme/monokai.css">

<script src="design/js/codemirror/lib/codemirror.js"></script>

<script src="design/js/codemirror/mode/smarty/smarty.js"></script>
<script src="design/js/codemirror/mode/smartymixed/smartymixed.js"></script>
<script src="design/js/codemirror/mode/xml/xml.js"></script>
<script src="design/js/codemirror/mode/htmlmixed/htmlmixed.js"></script>
<script src="design/js/codemirror/mode/css/css.js"></script>
<script src="design/js/codemirror/mode/javascript/javascript.js"></script>

<script src="design/js/codemirror/addon/selection/active-line.js"></script>

{literal}
    <style type="text/css">

        .CodeMirror{
            font-family:'Courier New';
            margin-bottom:10px;
            border:1px solid #c0c0c0;
            background-color: #ffffff;
            height: auto;
            min-height: 300px;
            width:100%;
        }
        .CodeMirror-scroll
        {
            overflow-y: hidden;
            overflow-x: auto;
        }
        .cm-s-monokai .cm-smarty.cm-tag{color: #ff008a;}
        .cm-s-monokai .cm-smarty.cm-string {color: #007000;}
        .cm-s-monokai .cm-smarty.cm-variable {color: #ff008a;}
        .cm-s-monokai .cm-smarty.cm-variable-2 {color: #ff008a;}
        .cm-s-monokai .cm-smarty.cm-variable-3 {color: #ff008a;}
        .cm-s-monokai .cm-smarty.cm-property {color: #ff008a;}
        .cm-s-monokai .cm-comment {color: #505050;}
        .cm-s-monokai .cm-smarty.cm-attribute {color: #ff20Fa;}
    </style>

<script>
    $(function() {
        // Сохранение кода аяксом
        function save()
        {
            $('.CodeMirror').css('background-color','#e0ffe0');
            content = editor.getValue();

            $.ajax({
                type: 'POST',
                url: 'ajax/save_script.php',
                data: {'content': content, 'theme':'{/literal}{$theme}{literal}', 'script': '{/literal}{$script_file}{literal}', 'session_id': '{/literal}{$smarty.session.id}{literal}'},
                success: function(data){
                    $('.CodeMirror').animate({'background-color': '#272822'});
                },
                dataType: 'json'
            });
        }

        // Нажали кнопку Сохранить
        $('input[name="save"]').click(function() {
            save();
        });

        // Обработка ctrl+s
        var isCtrl = false;
        var isCmd = false;
        $(document).keyup(function (e) {
            if(e.which == 17) isCtrl=false;
            if(e.which == 91) isCmd=false;
        }).keydown(function (e) {
            if(e.which == 17) isCtrl=true;
            if(e.which == 91) isCmd=true;
            if(e.which == 83 && (isCtrl || isCmd)) {
                save();
                e.preventDefault();
            }
        });
    });
</script>
{/literal}

<h1>Тема {$theme}, скрипт {$script_file}</h1>

{if $message_error}
    <!-- Системное сообщение -->
    <div class="message message_error">
	<span class="text">
	{if $message_error == 'permissions'}Установите права на запись для файла {$script_file}
    {elseif $message_error == 'theme_locked'}Текущая тема защищена от изменений. Создайте копию темы.
    {else}{$message_error}{/if}
	</span>
    </div>
    <!-- Системное сообщение (The End)-->
{/if}

<!-- Список файлов для выбора -->
<div class="block layer">
    <div class="templates_names">
        {foreach $scripts as $s}
            <a {if $script_file == $s}class="selected"{/if} href='index.php?module=ScriptsAdmin&file={$s}'>{$s}</a>
        {/foreach}
    </div>
</div>

{if $script_file}
    <div class="block">
        <form>
            <textarea id="script_content" name="script_content" style="width:700px;height:500px;">{$script_content|escape}</textarea>
        </form>

        <input class="button_green button_save" type="button" name="save" value="Сохранить" />
    </div>

    {* Подключение редактора *}
{literal}
    <script>
        var editor = CodeMirror.fromTextArea(document.getElementById("script_content"), {
            mode: "javascript",
            lineNumbers: true,
            styleActiveLine: true,
            matchBrackets: false,
            enterMode: 'keep',
            indentWithTabs: false,
            indentUnit: 2,
            tabMode: 'classic',
            theme : 'monokai'
        });
    </script>
{/literal}

{/if}