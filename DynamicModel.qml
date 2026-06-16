import QtQuick 2.15
import QtQuick3D 1.15

Node {
    id: rootNode

    property string modelName: "f117"
    property vector3d modelScale: Qt.vector3d(1, 1, 1)

    Component.onCompleted: {
        var meshUrls = modelProvider.getMeshUrls(modelName);
        var materialUrl = modelProvider.getMaterialQmlUrl(modelName);

        console.log("=== Загрузка модели:", modelName, "===");
        console.log("URL материала:", materialUrl);

        var modelComponent = Qt.createComponent("SingleModel.qml");
        if (modelComponent.status !== Component.Ready) {
            console.error("❌ Ошибка SingleModel.qml:", modelComponent.errorString());
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
                console.log("✅ Материал успешно загружен из:", materialUrl);
            } else {
                console.error("❌ Ошибка загрузки материала:", matComponent.errorString());
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
                console.error("❌ Ошибка создания модели:", meshUrls[i]);
            }
        }

        console.log("✅ Завершено. Объектов:", rootNode.children.length);
    }
}

//import QtQuick 2.15
//import QtQuick3D 1.15

//Node {
//    id: rootNode

//    property string modelName: "f117"
//    property vector3d modelScale: Qt.vector3d(25, 25, 25)

//    Component.onCompleted: {
//        var urls = modelProvider.getMeshUrls(modelName);
//        console.log("Загрузка модели:", modelName);

//        // Загружаем компонент материала
//        var materialComponent = Qt.createComponent("Shahed.qml");
//        var modelComponent = Qt.createComponent("SingleModel.qml");

//        var material = materialComponent.createObject(rootNode);

//        for (var i = 0; i < urls.length; i++) {
//            var model = modelComponent.createObject(rootNode, {
//                "source": urls[i],
//                "scale": modelScale,
//                "materials": material ? [material] : []
//            });
//        }
//    }
//}


//import QtQuick 2.15
//import QtQuick3D 1.15

//Node {
//    id: rootNode

//    property string modelName: "f117"
////    property vector3d modelScale: Qt.vector3d(25, 25, 25)
//    property vector3d modelScale: Qt.vector3d(.5, .5, .5)

//    Component.onCompleted: {
//        // Получаем список URL из C++
//        var urls = modelProvider.getMeshUrls(modelName);
//        console.log("=== Загрузка модели:", modelName, "===");
//        console.log("Найдено файлов:", urls.length);

//        // Создаем компонент для каждой части
//        var modelComponent = Qt.createComponent("SingleModel.qml");

//        if (modelComponent.status !== Component.Ready) {
//            console.error("❌ Ошибка загрузки SingleModel.qml:", modelComponent.errorString());
//            return;
//        }

//        // Создаем каждую модель и добавляем как дочерний элемент rootNode
//        for (var i = 0; i < urls.length; i++) {
//            var model = modelComponent.createObject(rootNode, {
//                "source": urls[i],
//                "scale": modelScale
//            });

//            if (model === null) {
//                console.error("❌ Не удалось создать модель для:", urls[i]);
//            }
//        }

//        console.log("✅ Загрузка завершена. Создано объектов:", rootNode.children.length);
//    }
//}


//import QtQuick 2.15
//import QtQuick3D 1.15

//Node {
//    id: rootNode

//    property string modelName: "f117"
//    property vector3d modelScale: Qt.vector3d(35, 35, 35)
//    property var meshUrls: modelProvider.getMeshUrls(modelName)

//    // ОТЛАДКА: Смотрим, что пришло из C++
////    Component.onCompleted: {
////        console.log("=== ОТЛАДКА INSTANTIATOR ===")
////        console.log("Количество URL:", meshUrls.length)
////        if (meshUrls.length > 0) {
////            console.log("Первый URL:", meshUrls[0])
////            console.log("Тип первого URL:", typeof meshUrls[0])
////        }
////    }

////    property var meshUrls: "file:///home/user/Devel/build-Simple3DViewer_Qt5-Qt_5_15_2_gcc_64-Debug/models/f117/us_500_lb_gbu_12_paveway_2_12_0.mesh"

//    Repeater {
//        model: rootNode.meshUrls

//        // Repeater создает Node, внутри которого Model
//        delegate: Node {
//            Model {
//                source: modelData
//                scale: Qt.vector3d(25, 25, 25)//rootNode.modelScale

//                materials: DefaultMaterial {
//                    diffuseColor: "red"//"#888888"
//                    specularAmount: 0.8
//                }
//            }
//        }
//    }

////    Instantiator {
////        model: rootNode.meshUrls

////        delegate: Model {
////            source: modelData
////            scale: Qt.vector3d(25, 25, 25)//rootNode.modelScale

////            materials: DefaultMaterial {
////                diffuseColor: "#555555"
////                specularAmount: 0.5
////            }

////            // ОТЛАДКА: Видим, какие файлы пытаются загрузиться
////            Component.onCompleted: {
////                console.log("!!!!!!!!!!!!!!!!!!Создан Model для:", source)
////            }
////        }
////    }

//// Test
//    Model {
//        source: "file:///home/user/Devel/build-Simple3DViewer_Qt5-Qt_5_15_2_gcc_64-Debug/models/f117/vehicle_fuse_46_0.mesh"
//        scale: rootNode.modelScale
//        materials: DefaultMaterial {
//            //diffuseColor: "yellow"
//            specularAmount: 0.8
//        }
//    }

////    Component.onCompleted: {
////        console.log(meshUrls)
////    }
//}

////Node {

////    // Запрашиваем список файлов у C++
////    property var meshUrls: modelProvider.getMeshUrls(modelName)

////    Instantiator {
////        model: rootNode.meshUrls

////        delegate: Model {
////            position: Qt.vector3d(0, 0, 0)
////            source: modelData // QUrl конкретного файла
//////            scale: rootNode.modelScale
////            scale: Qt.vector3d(25, 25, 25)
////            ////                    NumberAnimation on eulerRotation.x {
////            ////                        from: 0; to: 360; duration: 8000; loops: Animation.Infinite
////            ////                    }
////            //            NumberAnimation on eulerRotation.y {
////            //                from: 0; to: 360; duration: 8000; loops: Animation.Infinite
////            //            }
////            ////                    NumberAnimation on eulerRotation.z {
////            ////                        from: 0; to: 360; duration: 8000; loops: Animation.Infinite
////            ////                    }

////            // Резервный материал, если в .mesh он не зашит
//////            materials: DefaultMaterial {
//////                diffuseColor: "yellow"
//////                specularAmount: 0.5
//////            }
////            //            source: "#Cube" // Встроенный примитив Qt
////            //            position: Qt.vector3d(0, 0, 0)
////            //            scale: Qt.vector3d(2, 2, 2) // Делаем его большим
////            //            materials: DefaultMaterial {
////            //                diffuseColor: "yellow" // Ярко-красный, чтобы точно заметить
////            //                specularAmount: 0.5
////            //            }
////        }
////    }
////}
