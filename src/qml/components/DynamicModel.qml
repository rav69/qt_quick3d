// ============================================================
// src/qml/components/DynamicModel.qml
// ============================================================

import QtQuick 2.15
import QtQuick3D 1.15

Node {
    id: rootNode

    property bool debugInfo: false
    property string modelName: "f117"
    property vector3d modelScale: Qt.vector3d(1, 1, 1)

    Component.onCompleted: {
        var meshUrls = modelProvider.getMeshUrls(modelName);
        var materialUrl = modelProvider.getMaterialQmlUrl(modelName);

        if (debugInfo) console.log("=== Загрузка модели:", modelName, "===");
        if (debugInfo) console.log("URL материала:", materialUrl);

        var modelComponent = Qt.createComponent("SingleModel.qml");
        if (modelComponent.status !== Component.Ready) {
            if (debugInfo) console.error("❌ Ошибка SingleModel.qml:", modelComponent.errorString());
            return;
        }

        var materialInstance = null;

        // 1. Загружаем материал, если он существует
        if (materialUrl !== "") {
            var matComponent = Qt.createComponent(materialUrl);
            if (matComponent.status === Component.Ready) {
                // Создаем экземпляр материала.
                // Важно: создаем его с родителем rootNode, чтобы он жил в памяти
                materialInstance = matComponent.createObject(rootNode);
                if (debugInfo) console.log("✅ Материал успешно загружен из:", materialUrl);
            } else {
                if (debugInfo) console.error("❌ Ошибка загрузки материала:", matComponent.errorString());
            }
        }

        // 2. Создаем меши и назначаем им материал
        for (var i = 0; i < meshUrls.length; i++) {
            var props = {
                "source": meshUrls[i],
                "scale": modelScale
            };

            // Если материал загрузился, передаем его в модель как массив
            if (materialInstance) {
                props["materials"] = [materialInstance];
            }

            var model = modelComponent.createObject(rootNode, props);
            if (!model) {
                if (debugInfo) console.error("❌ Ошибка создания модели:", meshUrls[i]);
            }
        }

        if (debugInfo) console.log("✅ Завершено. Объектов:", rootNode.children.length);
    }
}
