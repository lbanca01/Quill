import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import org.mauikit.controls 1.3 as Maui

Maui.ApplicationWindow
{
    id: root
    title: i18n("Quill")
    Maui.Style.styleType: Maui.Handy.isAndroid ? (settings.darkMode ? Maui.Style.Dark : Maui.Style.Light) : undefined

    property font defaultFont : Qt.font({family: "Noto Sans Mono", pointSize: Maui.Style.fontSizes.huge})
}
