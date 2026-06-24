import QtQuick 2.15
import QtQuick3D 1.15

Node {
    id: sketchfab_model
    eulerRotation.x: -90

    Node {
        id: root

        Node {
            id: gLTF_SceneRootNode
            eulerRotation.x: 90

            Node {
                id: buk_M3_0
                eulerRotation.x: -90
                scale.x: -1
                scale.y: -1
                scale.z: -1

                Model {
                    id: object_4
                    source: "meshes/object_4.mesh"

                    PrincipledMaterial {
                        id: material_001_material
                        baseColor: "#ff656565"
                        metalness: 0.882288
                        roughness: 0.711621
                        cullMode: Material.NoCulling
                    }
                    materials: [
                        material_001_material
                    ]
                }

                Model {
                    id: object_5
                    source: "meshes/object_5.mesh"
                    materials: [
                        material_001_material
                    ]
                }

                Model {
                    id: object_6
                    source: "meshes/object_6.mesh"
                    materials: [
                        material_001_material
                    ]
                }

                Model {
                    id: object_7
                    source: "meshes/object_7.mesh"
                    materials: [
                        material_001_material
                    ]
                }

                Model {
                    id: object_8
                    source: "meshes/object_8.mesh"
                    materials: [
                        material_001_material
                    ]
                }

                Model {
                    id: object_9
                    source: "meshes/object_9.mesh"
                    materials: [
                        material_001_material
                    ]
                }

                Model {
                    id: object_10
                    source: "meshes/object_10.mesh"
                    materials: [
                        material_001_material
                    ]
                }
            }

            Node {
                id: missile_1
                x: 2.07897
                y: -0.281695
                z: 6.36598
                eulerRotation.y: -90
                eulerRotation.z: -90
                scale.x: -1
                scale.y: -1
                scale.z: -1

                Model {
                    id: object_12
                    source: "meshes/object_12.mesh"

                    PrincipledMaterial {
                        id: material_002_material
                        baseColor: "#ff5a5a5a"
                        metalness: 0
                        roughness: 0.5
                        cullMode: Material.NoCulling
                    }
                    materials: [
                        material_002_material
                    ]
                }
            }

            Node {
                id: missile_001_2
                x: -1.40354
                y: -0.281695
                z: 7.44572
                eulerRotation.y: 90
                eulerRotation.z: 90
                scale.x: -1
                scale.y: -1
                scale.z: -1

                Model {
                    id: object_14
                    source: "meshes/object_14.mesh"

                    PrincipledMaterial {
                        id: material_003_material
                        baseColor: "#ff656565"
                        metalness: 0
                        roughness: 0.5
                        cullMode: Material.NoCulling
                    }
                    materials: [
                        material_003_material
                    ]
                }
            }

            Node {
                id: plane_5
                y: -0.531328
                scale.x: 18.0057
                scale.y: 1.59818
                scale.z: 45.4274

                Model {
                    id: object_16
                    source: "meshes/object_16.mesh"

                    PrincipledMaterial {
                        id: material_004_material
                        baseColor: "#ff0e0e0e"
                        metalness: 0
                        roughness: 0.5
                        cullMode: Material.NoCulling
                    }
                    materials: [
                        material_004_material
                    ]
                }
            }
        }
    }
}
