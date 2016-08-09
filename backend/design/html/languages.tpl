{* Вкладки *}
{capture name=tabs}
    {if in_array('settings', $manager->permissions)}
        <li><a href="index.php?module=SettingsAdmin">Настройки</a></li>
    {/if}
    {if in_array('currency', $manager->permissions)}
        <li><a href="index.php?module=CurrencyAdmin">Валюты</a></li>
    {/if}
    {if in_array('delivery', $manager->permissions)}
        <li><a href="index.php?module=DeliveriesAdmin">Доставка</a></li>
    {/if}
    {if in_array('payment', $manager->permissions)}
        <li><a href="index.php?module=PaymentMethodsAdmin">Оплата</a></li>
    {/if}
    {if in_array('managers', $manager->permissions)}
        <li><a href="index.php?module=ManagersAdmin">Менеджеры</a></li>
    {/if}
    <li class="active"><a href="index.php?module=LanguagesAdmin">Языки</a></li>
    {if in_array('languages', $manager->permissions)}
        <li><a href="index.php?module=TranslationsAdmin">Переводы</a></li>
    {/if}
{/capture}

{* Title *}
{$meta_title='Языки' scope=parent}

<div id="header">
    <h1>Языки</h1>
    <a class="add" href="{url module=LanguageAdmin}">Добавить язык</a>
</div>

{if $languages}
    <div id="main_list">
        <form id="list_form" method="post">
            <input type="hidden" name="session_id" value="{$smarty.session.id}">
            <div id="list">
                {foreach $languages as $language}
                    <div class="{if !$language->enabled}invisible{/if} row">
                        <input type="hidden" name="positions[]" value="{$language->id}">

                        <div class="move cell">
                            <div class="move_zone"></div>
                        </div>
                        <div class="checkbox cell">
                            <input type="checkbox" id="{$language->id}" name="check[]" value="{$language->id}"/>
                            <label for="{$language->id}">
                        </div>
                        <div class="name cell">
                            <a href="{url module=LanguageAdmin id=$language->id return=$smarty.server.REQUEST_URI}">
                                {$language->{'name_'|cat:$current_language->label}|escape} [{$language->label|escape}]
                            </a>
                        </div>
                        <div class="icons cell lang">
                            <a class="enable" title="Активен" href="#"></a>
                            <a class="delete" title="Удалить" href="#"></a>
                        </div>
                        <div class="clear"></div>
                    </div>
                {/foreach}
            </div>
            <div id="action">
                <label id="check_all" class='dash_link'>Выбрать все</label>
                <span id="select">
                <select name="action">
                    <option value="enable">Включить</option>
                    <option value="disable">Выключить</option>
                    <option value="delete">Удалить</option>
                </select>
                </span>
                <input id="apply_action" class="button_green" type="submit" value="Применить">
            </div>
        </form>
    </div>
{else}
    Нет языков
{/if}

<div id="right_menu">

</div>
{literal}
    <script>
        $(function () {

            // Сортировка списка
            $("#list").sortable({
                items: ".row",
                tolerance: "pointer",
                handle: ".move_zone",
                scrollSensitivity: 40,
                opacity: 0.7,
                forcePlaceholderSize: true,
                axis: 'y',

                helper: function (event, ui) {
                    if ($('input[type="checkbox"][name*="check"]:checked').size() < 1) return ui;
                    var helper = $('<div/>');
                    $('input[type="checkbox"][name*="check"]:checked').each(function () {
                        var item = $(this).closest('.row');
                        helper.height(helper.height() + item.innerHeight());
                        if (item[0] != ui[0]) {
                            helper.append(item.clone());
                            $(this).closest('.row').remove();
                        }
                        else {
                            helper.append(ui.clone());
                            item.find('input[type="checkbox"][name*="check"]').attr('checked', false);
                        }
                    });
                    return helper;
                },
                start: function (event, ui) {
                    if (ui.helper.children('.row').size() > 0)
                        $('.ui-sortable-placeholder').height(ui.helper.height());
                },
                beforeStop: function (event, ui) {
                    if (ui.helper.children('.row').size() > 0) {
                        ui.helper.children('.row').each(function () {
                            $(this).insertBefore(ui.item);
                        });
                        ui.item.remove();
                    }
                },
                update: function (event, ui) {
                    $("#list_form input[name*='check']").attr('checked', false);
                    $("#list_form").ajaxSubmit(function () {
                        colorize();
                    });
                }
            });

            // Раскраска строк
            function colorize() {
                $("#list div.row:even").addClass('even');
                $("#list div.row:odd").removeClass('even');
            }

            // Раскрасить строки сразу
            colorize();

            // Выделить все
            $("#check_all").click(function () {
                $('#list input[type="checkbox"][name*="check"]').attr('checked', $('#list input[type="checkbox"][name*="check"]:not(:checked)').length > 0);
            });

            // Удалить
            $("a.delete").click(function () {
                $('#list input[type="checkbox"][name*="check"]').attr('checked', false);
                $(this).closest(".row").find('input[type="checkbox"][name*="check"]').attr('checked', true);
                $(this).closest("form").find('select[name="action"] option[value=delete]').attr('selected', true);
                $(this).closest("form").submit();
            });

            $("form").submit(function () {
                if ($('select[name="action"]').val() == 'delete' && !confirm('Подтвердите удаление'))
                    return false;
            });

            // Скрыт/Видим
            $("a.enable").click(function () {
                var icon = $(this);
                var line = icon.closest(".row");
                var id = line.find('input[type="checkbox"][name*="check"]').val();
                var state = line.hasClass('invisible') ? 1 : 0;
                icon.addClass('loading_icon');
                $.ajax({
                    type: 'POST',
                    url: 'ajax/update_object.php',
                    data: {
                        'object': 'language',
                        'id': id,
                        'values': {'enabled': state},
                        'session_id': '{/literal}{$smarty.session.id}{literal}'
                    },
                    success: function (data) {
                        icon.removeClass('loading_icon');
                        if (state)
                            line.removeClass('invisible');
                        else
                            line.addClass('invisible');
                    },
                    dataType: 'json'
                });
                return false;
            });
        });

    </script>
{/literal}