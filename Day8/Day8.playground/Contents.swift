import Cocoa
//
////MARK: 1)파라미터에서 defualt값 유지하는 법
////❤️ 1.기본값을 지정
////end값에 12값을 넣어두면 호출생략때 오류없이 default값 나옴
//func mutilpleNum(for number: Int, end: Int = 12) {
//    for i in 1...end {
//        print("\(i) x \(number) is \(i * number)")
//    }
//}
//mutilpleNum(for: 5, end: 20)
//mutilpleNum(for: 8)
//
////❤️ 2.keepingCapacity: true // 배열요소가 지워져도 메모리 유지하기
////removeAll()->배열의 모든 항목을 제거한 다음 배열에 할당된 모든 메모리를 해제
////새 항목을 배열에 다시 추가하려고 할 수 있으므로 이전 용량을 유지하면서 항목을 제거방식 기본적으로는 keepingVapacity:false값
//var people = ["dami", "yumi", "Ray"]
//print(people.count)
//people.removeAll(keepingCapacity: true)
//print(people.count)
//
//func who(_ name: String, student: Bool = true) {
//    if student{
//        print("\(name) is a student :\(student) ")
//    } else {
//        print("\(name) is a student :\(student) ")
//    }
//}
//who("dami")
//who("Yumi",student: false)
////참
//MARK: 2)오류 발생처리 💚1 throw: 오류 던지기 💜2 try catch: 오류가 던져지는 것에 대비하여 던져진 오류를 처리(사용자에게 알리거나 다른실행)중 하나

//1Throw로 오류를 던진후 2 오류처리를 위해 호출부에서 do, try, catch문을 이용하여 작성합니다.

/*단계
1.발생할 수 있는 오류를 enum 정의
2.오류플래그 함수를 작성
3.해당 함수를 호출하고 발생할 수 있는 오류를 처리
*/

//1 enum에 오류타입명 정의
enum PasswordError: Error {
    case short, obvious
}
//2.오류가 나는 조건을 명시 : 오류 날수있는 코드를 사용자가 지정해서 오류를 지정해서 함수처럼 사용됨
//-오류가 발생할 수 있다는 것 표현 : throws를 ->전에 표시(반환 전에 오류가 발생하면, 오류객체를 반환한다는 의미)
//- 오류가 발생됐다는 표현 : throw와 오류명 집어넣기(return하는 것과 유사)
func checkPassword(_ password: String) throws -> String {
    // 오류가 나는 조건을 throws와 함께 배치
if password.count < 5 {
    throw PasswordError.short
}

if password == "123456" {
    throw PasswordError.obvious
}

if password.count < 8 {
    return "OK"
} else if password.count < 10 {
    return "Good"
} else {
    return "Excellent"
}
}

//2 do - try - catch로 접근



//⭐️형식
//1.do {try 오류발생가능성있는 코드
        //   통과 코드}
//catch 오류 패턴 {처리 코드}

//do절에서 오류를 던지고, catch 절에서 오류를 전달받아 예외처리를 해주는 것이다.
//let string = "12345"
//
//do {
//    let result = try checkPassword(string) // 오류가능성있는 함수
//    print("패스워드 적합: \(result)")   //OK
//} catch {
//    print("There was an error.")   //에러
//}
///**ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ**/
//let string1 = "12345"
//
//do {// 실행
//    let result1 = try checkPassword(string1)
//    print("패스워드 적합: \(result1)")
//}
////특정 에러호출, 에러호출
//  catch PasswordError.short {
//    print("너무 짧아요.")
//} catch PasswordError.obvious {
//    print("이미 있는 번호에요")
//} catch {
//    print("에러발생")
//}
//


/*
- 문제는 1부터 10,000까지의 정수를 받아들이고 해당 숫자의 정수 제곱근을 반환하는 함수를 작성하는 것입니다. 쉽게 들리지만 몇 가지 주의 사항이 있습니다.
 
 Swift의 내장 sqrt()함수나 이와 유사한 기능을 사용할 수 없습니다.
 직접 제곱근을 찾아야 합니다.
 숫자가 1보다 작거나 10,000보다 크면 "out of bounds" 오류가 발생합니다.
 정수 제곱근만 고려해야 합니다.
 예를 들어 3의 제곱근이 1.732인 것에 대해 걱정하지 마십시오.
 제곱근을 찾을 수 없으면 "근이 없음" 오류를 발생시킵니다.
 다시 말하지만, 숫자 X가 있는 경우 X의 제곱근은 자신을 곱하면 X가 되는 또 다른 숫자가 됩니다. 따라서 3x3은 9이고 제곱근 25이므로 9의 제곱근은 3입니다. 5x5는 25이므로 5입니다.입력
*/


// 🔔제곱근: 1일때 1제곱 대입 | 4 일때 1,2의 제곱 대입
//    =>1...num/2+1 까지의 대입을 넣어본다.

//error 정리
enum errors :Error {
    case outOfBound, noRoot
}
//판별
func sqrtNum(_ num:Int) throws -> Int {
    //1보다 작거나 10,000보다 크면
    if num<1 || num>10_000 {
        throw errors.outOfBound
    }
    for i in 1...(num/2+1){
        if i*i == num {
            return i
        }
    }
    throw errors.noRoot
}
func input(){
    let num = 10000//Int(readLine()!)!
    
    do{
        let n = try sqrtNum(num)
            print("\(n) is a SqrtNum of \(num)")
    }catch errors.outOfBound{
        print ("Out of bound")
    }catch errors.noRoot {
        print("No root")
    }
    catch {
        print("error")
    }
    
}
input()

