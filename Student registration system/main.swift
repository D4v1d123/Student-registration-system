import Foundation

/*
Problema: Sistema de Registro de Estudiantes

Se necesita un sistema de registro de estudiantes para una escuela. Los estudiantes se inscriben en cursos y se almacena su información personal, como nombre, edad y número de identificación. Cada estudiante puede inscribirse en varios cursos. El sistema también debe permitir buscar estudiantes por su número de identificación y ver los cursos en los que están inscritos.
 
Considera las operaciones de inserción, búsqueda y recuperación de información de manera eficiente a medida que aumenta el número de estudiantes.
 
Data structure to use:
 
 ❌   Array
 ❌   Basic list
 ❌   Linked list
 ❌   Doubly linked list
 ❌   Circular doubly linked list
 ✅   Set
 ✅   Dictionary
 ❌   Stack
 ❌   Queue
 ❌   Offset
 ❌   Objects
 ❌   Tuples
 */

class RegisterStudents {
    var registeredStudents: [Int: Any] = [:]

    //Register the student information.
    func registerStudent (id: Int, name: String, age: Int) {
        //Add the student to the dictionary.
        registeredStudents[id] = [
            "name": name,
            "age": age,
            "course": []
        ]
    }

    //Add courses to the student.
    func addCourseStudent (id: Int, course: String) {
        //Break down the 'registeredStudents' dictionary.
        var student = registeredStudents[id] as! [String: Any]
        var coursesStudent = student["course"] as! [String]
        
        coursesStudent.append(course)
        student["course"] = coursesStudent
        registeredStudents[id] = student
    }

    //Delete courses of the student.
    func delCourseStudent (id: Int, course: String) {
        //Break down the 'registeredStudents' dictionary.
        var student = registeredStudents[id] as! [String: Any]
        var coursesStudent = student["course"] as! [String]
        
        var iterator = 0
        for item in coursesStudent {
            if item == course {
                coursesStudent.remove(at: iterator)
            }
            iterator += 1
        }
        
        //Save modification of the courses.
        student["course"] = coursesStudent
        registeredStudents[id] = student
    }
    
    //Select a course of a student.
    func selectCourseStudent (id: Int) -> String? {
        //Break down the 'registeredStudents' dictionary.
        let student = registeredStudents[id] as? [String: Any]
        //Check that the student is registered
        if student != nil {
            let coursesStudent = student!["course"] as! [String]
                    
            if !coursesStudent.isEmpty {
                //Show all courses of the student.
                print("\nDigite el número correspondiente a un curso: ")
                var iterator = 1
                for item in coursesStudent {
                    print("\n\(iterator). \(item)")
                    iterator += 1
                }
                        
                //Check the chosen option or course.
                let status = true
                        
                while status {
                    //Check that option selected by the user is a number.
                    if let option = Int(readLine()!) {
                        //Check that option is in the given menu.
                        if option <= coursesStudent.count {
                            return coursesStudent[option - 1]
                        } else {
                            print("\n‼️La opción no se encuentra en el menu dado.‼️\n")
                        }
                    } else {
                        print("\n‼️Opción incorrecta.‼️\n")
                    }
                }
            } else {
                print("\n‼️No hay ningun curso registrado.‼️\n")
                return nil
            }
        } else {
            print("\n‼️El estudiante con el número de identificación \"\(id)\" no se encuentra registrado.‼️\n")
            return nil
        }
    }
    
    //Show the student information.
    func showStudentInfo (id: Int) {
        //Break down the 'registeredStudents' dictionary.
        let student = registeredStudents[id] as! [String: Any]
        let coursesStudent = student["course"] as! [String]
        
        print("\nNombre: \(student["name"]!).")
        print("Edad: \(student["age"]!).")
        
        if coursesStudent.isEmpty {
            print("Cursos: No tiene cursos registrados.")
        } else {
            print("Cursos:")
            for item in coursesStudent {
                print("        \(item)")
            }
        }
    }
}


class RegisterCourses {
    var courses: [String] = []
    
    //Add a new course.
    func addCourse (course: String) {
        courses.append(course)
    }
    
    //Delete a course.
    func delCourse (course: String) {
        var iterator = 0
        for item in courses {
            if item == course {
                courses.remove(at: iterator)
            }
            iterator += 1
        }
    }
    
    //Select or enroll a course.
    func selectCourses () -> String? {
        if !courses.isEmpty {
            //Show all avalaible courses.
            print("\nDigite el número correspondiente a un curso: ")
            var iterator = 1
            for item in courses {
                print("\n\(iterator). \(item)")
                iterator += 1
            }
            
            //Check the chosen option or course.
            let status = true
            
            while status {
                //Check that option selected by the user is a number.
                if let option = Int(readLine()!) {
                    //Check that option is in the given menu.
                    if option <= courses.count {
                        return courses[option - 1]
                    } else {
                        print("\n‼️La opción no se encuentra en el menu dado.‼️\n")
                    }
                } else {
                    print("\n‼️Opción incorrecta.‼️\n")
                }
            }
        } else {
            print("\n‼️No hay ningun curso registrado en el sistema.‼️\n")
            return nil
        }
    }
    
    //Select among the courses that are not registered by the student
    func selectCoursesNotRegisteredByStudent (id: Int, registeredStudents: [Int: Any]) -> String? {
        if !courses.isEmpty {
            //Break down the 'registeredStudents' dictionary.
            let student = registeredStudents[id] as! [String: Any]
            let coursesStudent = Set(student["course"] as! [String])
            let registeredCourses = Set(courses)
            
            let coursesNotRegisterByStudent = Array(registeredCourses.subtracting(coursesStudent))
            
            
            //Show all avalaible courses for the student.
            print("\nDigite el número correspondiente a un curso: ")
            var iterator = 1
            for item in coursesNotRegisterByStudent {
                print("\n\(iterator). \(item)")
                iterator += 1
            }
            
            //Check the chosen option or course.
            let status = true
            
            while status {
                //Check that option selected by the user is a number.
                if let option = Int(readLine()!) {
                    //Check that option is in the given menu.
                    if option <= coursesNotRegisterByStudent.count {
                        return coursesNotRegisterByStudent[option - 1]
                    } else {
                        print("\n‼️La opción no se encuentra en el menu dado.‼️\n")
                    }
                } else {
                    print("\n‼️Opción incorrecta.‼️\n")
                }
            }
        } else {
            print("\n‼️No hay ningun curso registrado en el sistema.‼️\n")
            return nil
        }
    }
}


var statusMenu = true
var registerStudent = RegisterStudents()
var registerCourse = RegisterCourses()

while statusMenu {
    print("\nSISTEMA DE REGISTRO DE ESTUDIANTES.\n")
    print("Digite un número correspondiente a una opción: \n1. Registrar un nuevo curso. \n2. Eliminar un curso. \n3. Registrar un estudiante nuevo. \n4. Registrar un estudiante a un curso. \n5. Eliminar un curso de un estudiante. \n6. Consultar la información de un estudiante. \n7. Salir del programa. ")
    if let menu = Int(readLine()!) {
        switch menu {
            case 1:
                var menu = true
                while menu {
                    print("\nREGISTRAR UN NUEVO CURSO.\n")
                    print("Ingrese el nombre del curso:")
                    
                    if let courseName = readLine() {
                        registerCourse.addCourse(course: courseName)
                        print("\nCurso registrado con exito.\n")
                        menu = false
                    } else {
                        print("‼️No ha ingresado ningun nombre.‼️")
                    }
                }
                break
            
            case 2:
                print("\nELIMINAR UN CURSO.\n")
                let course = registerCourse.selectCourses()
                if course != nil {
                    registerCourse.delCourse(course: course!)
                    print("\nEl curso ha sido eliminado con exito.\n")
                }
                break
            
            case 3:
                var menu = true
                while menu {
                    print("\nREGISTRAR UN ESTUDIANTE.\n")
                    print("Digite el: \n\nNúmero de identificación:")
                    if let id = Int(readLine()!) {
                        print("Nombre completo:")
                        if let name = readLine() {
                            print("Edad:")
                            if let age = Int(readLine()!){
                                registerStudent.registerStudent(id: id, name: name, age: age)
                                let course = registerCourse.selectCourses()
                                if course != nil {
                                    registerStudent.addCourseStudent(id: id, course: course!)
                                }
                                print("\nEstudiante registrado con exito.\n")
                                menu = false
                            } else {
                                print("\n‼️Solo se admiten números.‼️")
                            }
                        } else {
                            print("‼️No ha ingresado ningun nombre.‼️")
                        }
                    } else {
                        print("\n‼️Solo se admiten números.‼️")
                    }
                }
                break
            
            case 4:
                var menu = true
                
                while menu {
                    print("\nREGISTRAR UN ESTUDIANTE A UN CURSO.\n")
                    print("Digite el número de identifiación del estudiante:")
                        if let id = Int(readLine()!) {
                            //Check that the student is registered
                            if registerStudent.registeredStudents[id] != nil {
                                let course = registerCourse.selectCoursesNotRegisteredByStudent(id: id, registeredStudents: registerStudent.registeredStudents)
                                if course != nil {
                                    registerStudent.addCourseStudent(id: id, course: course!)
                                    print("\nEl curso ha sido asignado con exito.\n")
                                }
                            } else {
                                print("\n‼️El estudiante con el número de identificación \"\(id)\" no se encuentra registrado.‼️\n")
                            }
                            menu = false
                        } else {
                            print("\n‼️Solo se admiten números.‼️")
                        }
                }
                break
            
            case 5:
                var menu = true
                
                while menu {
                    print("\nELIMINAR UN CURSO DE UN ESTUDIANTE.\n")
                    print("Digite el número de identifiación del estudiante:")
                        if let id = Int(readLine()!) {
                            let course = registerStudent.selectCourseStudent(id: id)
                            if course != nil {
                                registerStudent.delCourseStudent(id: id, course: course!)
                                print("\nEl curso ha sido eliminado con exito.\n")
                            }
                            menu = false
                        } else {
                            print("\n‼️Solo se admiten números.‼️")
                        }
                }
                break
                
            case 6:
                var menu = true
                
                while menu {
                    print("\nCONSULTAR LA INFORMACIÓN DE UN ESTUDIANTE.\n")
                    print("Digite el número de identifiación del estudiante:")
                        if let id = Int(readLine()!) {
                            if registerStudent.registeredStudents[id] != nil {
                                registerStudent.showStudentInfo(id: id)
                            } else {
                                print("\n‼️El estudiante con el número de identificación \"\(id)\" no se encuentra registrado.‼️\n")
                            }
                            menu = false
                        } else {
                            print("\n‼️Solo se admiten números.‼️")
                        }
                }
                break
                
            case 7:
                print("Adios 👋.")
                statusMenu = false
                break
            
            default:
                print("\n‼️La opción no se encuentra en el menu dado.‼️\n")
        }
    } else {
        print("\n‼️Solo se pueden digitar números.‼️\n")
    }
}
