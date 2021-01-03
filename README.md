# :iphone:  SE04-Nhom21.1
*(Tìm hiểu về JVM)*

---
## :large_blue_diamond: Mục lục
~~~
1. Giới thiệu
2. Đề tài
3. Mục tiêu
4. Giới thiệu chung
5. Giới thiệu khái quát về Java Virtual Machine
6. Java Virtual Machine(JVM) là gì?
7. Kiến trúc của một JVM
8. Tìm hiểu cách sử dụng một JVM đơn giản
9. Phân chia công việc
10. Tổng kết
~~~

---

## :large_blue_diamond: Giới thiệu
### Công nghệ phần mềm - SE04-Nhom21.1 
###### - Trường: Đại Học Khoa học Tự Nhiên - Đại học Quốc Gia Hà Nội.
###### - Khoa: Toán - Cơ - Tin học.
### Người hướng dẫn
###### - Thầy: [Bùi Sỹ Nguyên](https://www.facebook.com/nguyenbs).

### Thành viên nhóm
###### 1) Đặng Quang Vinh
###### 2) Nguyễn Công Hậu
###### 3) Nguyễn Văn Huy
###### 4) Phạm Văn Khải
    
## :large_blue_diamond: **Đề tài**
Tìm hiểu về JVM
    
## :large_blue_diamond: **Mục tiêu**
- Nghiên cứu kiến trúc và các thành phần cấu tạo của một máy ảo JVM, tìm hiểu cách sử dụng một JVM đơn giản (AJVM)

## :large_blue_diamond: **Giới thiệu chung**
Thập kỷ 90 của thế kỷ 20 là sự phát triển nhanh như vũ bão của mạng Internet, kèm theo đó là vô vàn các ứng dụng trên các môi trường, hệ điều hành (OS) và các hệ xử lý (CPU) khác nhau. Tuy nhiên có một điểm hạn chế lớn là lập trình viên phải rất vất vả khi chuyển đổi các ứng dụng của mình để các hệ thống khác nhau có thể sử dụng được.
23/5/1995, Sun Microsystems đã cho ra mắt công cụ lập trình Java với tiêu chí “Viết một lần, chạy khắp nơi” (Write Once, run anywhere), một ngôn ngữ lập trình hướng đối tượng (OOP) được thiết kế độc lập với hệ điều hành. Khác với phần lớn các ngôn ngữ lập trình thông thường, thay vì biên dịch mã nguồn thành mã máy hoặc thông dịch mã nguồn khi chạy, Java được thiết kế để biên dịch mã nguồn thành bytecode, sau đó sẽ được môi trường thực thi (runtime enviroment) chạy. Chương trình viết bằng Java có thể chạy trên mọi nền tảng (platform) khác nhau thông qua môi trường thực thi thích hợp hỗ trợ nền tảng đó. Môi trường thực thi của Java hiện hỗ trợ : Windows, Mac OS, Linux, Unix,...
Java Vitual Machine (JVM) bản chất là một chương trình có thể thực thi các đoạn mã lập trình của Java. Với máy ảo JVM, chương trình Java có thể chạy trên bất kỳ môi trường nào.
Với vai trò to lớn và ứng dụng rộng rãi mà JVM mang lại cho thấy tầm quan trọng của JVM, song việc tìm hiểu JVM gặp rất nhiều khó khăn do chưa có tài liệu mô tả chi tiết, rõ ràng nên báo cáo này sẽ đóng góp một phần kiến thức về JVM cho bạn đọc.

## :large_blue_diamond: **Giới thiệu khái quát về Java Virtual Machine**    
Tất cả các chương trình muốn thực thi được thì phải được biên dịch ra mã máy. Mỗi máy có hệ điều hành khác nhau (Windows, Mac Os, Linux,... ) và kiến trúc CPU khác nhau (CPU intel, CPU macintosh,...) vì vậy trước đây mỗi chương trình chỉ có thể thực thi được trên một loại máy với hệ điều hành và kiến trúc CPU nào đó, như vậy muốn thực thi chương trình trên máy có cấu trúc khác thì phải chỉnh sửa và biên dịch lại mã nguồn.
Khi Java ra đời, nó nhờ vào máy ảo Java để khắc phục khó khăn đó. Một chương trình được viết bằng Java sẽ được biên dịch ra mã của máy ảo Java (bytecode). Sau đó máy ảo sẽ chuyển mã bytecode thành mã máy tương ứng.

##### Máy ảo Java được sinh ra với 3 mục đích chính:
+ Dịch mã Java ra mã máy chạy được trên các hệ điều hành khác nhau
+ Tăng tốc độ 
+ Nâng cao độ bảo mật và tránh virus phá source code
    
## :large_blue_diamond: **Java Virtual Machine(JVM) là gì?** 
JVM bản chất là một chương trình có thể thực thi các đoạn mã lập trình của Java, và đặc điểm của các chương trình được viết bằng Java là đều có thể chạy trên bất kỳ môi trường nào miễn là có cài máy ảo JVM.
JVM quản lý bộ nhớ hệ thống và cung cấp môi trường thực thi cho ứng dụng Java, nó có hai chức năng chính là cho phép chương trình Java chạy trên mọi thiết bị, nền tảng khác nhau và quản lý, tối ưu bộ nhớ chương trình.
Trong hầu hết các trường hợp, các ngôn ngữ lập trình khác, trình biên dịch tạo ra mã cho một Hệ điều hành cụ thể nhưng trình biên dịch Java chỉ tạo Bytecode cho Máy ảo Java . Khi bạn chạy một chương trình Java, chương trình này sẽ chạy như một chuỗi trong quy trình JVM. JVM có trách nhiệm tải các tệp lớp của bạn, xác minh mã, diễn giải và thực thi chúng. Khi bạn phát hành một lệnh như java, JVM tải định nghĩa lớp cho lớp cụ thể đó và gọi phương thức chính của lớp đó. 
Khi các nhà phát triểu nói về JVM họ thường nghĩ tới các chương trình thực thi trong máy, đặc biệt là máy chủ, nó kiểm soát việc sử dụng tài nguyên cho ứng dụng Java. Điều đó khác với định nghĩa kỹ thuật của JVM, nó tuân thủ theo một đặc tả cho chương trình phầm mềm, miêu tả những yêu cầu sửa dụng chương trình và cung cấp môi trường thực thi code.

## :large_blue_diamond: **Kiến trúc của JVM** 
##### Các bước mà JVM vận hành:
+ Loads code (Tải mã)
+ Verifies code (Xác minh mã)
+ Executes code (Thực thi mã)

##### Sơ đồ đơn giản về máy ảo Java:
![alt text]( https://www.w3schools.in/wp-content/uploads/2014/08/Diagram-of-JVM.png "Title")
##### JVM được chia ra làm 3 hệ thống con chính:
+ Class Loader Subsystem: Tìm kiếm và nạp các file .class vào vùng nhớ Java
+ Runtime Data Area: Vùng nhớ hệ thống cấp phát cho JVM
+ Execution Engine: Chuyển các lệnh trong file .class thành mã máy tương ứng

![alt text](http://net-informations.com/java/intro/img/architecture.png "Title")

##### Class Loader Subsystem
Máy ảo Java có kiến trúc Class Loader Subsystem linh hoạt cho phép ứng dụng Java tải các lớp theo những cách tùy chỉnh. Trong JVM, mỗi và mọi lớp được tải bởi một số phiên bản của java.lang.ClassLoader. Bộ nạp lớp là một tệp lớp Java đặc biệt chịu trách nhiệm tải các lớp khác lên Máy ảo Java. Nếu một lớp Java được gọi và cần được thực thi trên Máy ảo Java, một thành phần Java đặc biệt, được gọi là bộ class Loader , được sử dụng để tìm lớp Java quan tâm, kéo lớp Java đó ra khỏi hệ thống tệp và thực thi bytecode của tệp lớp đó trên Máy ảo Java.

![alt text](http://net-informations.com/java/intro/img/classloader.png "Title")

##### Runtime Data Areas
Các máy ảo Java (JVM) định nghĩa Runtime Data Areas khác nhau được sử dụng trong thực thi một chương trình. Một số vùng dữ liệu này được tạo khi khởi động máy ảo Java và chỉ bị hủy khi thoát khỏi máy ảo Java. Mỗi vùng dữ liệu là mỗi luồng khác nhau. Các vùng dữ liệu của mỗi luồng được tạo khi một luồng được tạo và bị hủy khi luồng đó thoát.

![alt text](http://net-informations.com/java/intro/img/runtime.png "Title")

##### Execution Engine
Đây là cốt lõi của JVM. Execution Engine có thể giao tiếp với các vùng nhớ khác nhau của JVM. Mỗi luồng của một ứng dụng Java đang chạy là một execution riêng biệt. bytecode được gán cho Runtime Data Areas trong JVM thông qua Class Loader được thực thi bởi xecution Engine.
##### Interpreter
Đọc, thông dịch và thực thi các bytecode instructions từng dòng một. Do nó thông dịch và thực thi từng dòng một nên công việc thông dịch bytcode được thực hiện một cách nhanh chóng nhưng thực thi kết quả thì lại chậm. Đó là một nhược điểm của ngôn ngữ thông dịch. 

##### JIT Compiler
JIT Compiler chuyển đổi mã bytecode thành biểu thức cấp trung gian, IR (Biểu diễn trung gian), để thực hiện tối ưu hóa, và sau đó chuyển đổi biểu thức thành native code. Trình biên dịch JIT đã được giới thiệu để bù đắp những nhược điểm của trình thông dịch. Mục đích chính của trình biên dịch JIT là cải thiện hiệu suất. Trình biên dịch JIT duy trì một số lượng riêng biệt cho mọi phương thức trong nó. Bất cứ khi nào JVM chạy qua bất kỳ lệnh gọi phương thức nào, trước tiên phương thức đó sẽ được trình thông dịch thông dịch một cách bình thườn rồi trình biên dịch JIT tăng biến đếm tương ứng.

##### Garbage Collector
Garbage Collector (GC) là một tiến trình nhằm mục đích giải phóng bộ nhớ bị chiếm dụng mà không còn được sử dụng bởi bất kỳ đối tượng Java có thể truy cập nào và là một phần thiết yếu của hệ thống quản lý bộ nhớ động của máy ảo Java (JVM). Tất cả các đối tượng Java sẽ tự động lấy bộ nhớ mà chúng cần khi chúng được tạo ra và khi đối tượng không còn cần nữa, tiến trình Java Garbage Collection sẽ lấy lại bộ nhớ. Điều đó có nghĩa là GC đã theo dõi các live object và mọi thứ được chỉ định khác.

##### Native Method Interface
Native methods cho phép bạn sử dụng mã từ các ngôn ngữ khác như C hoặc C ++ trong mã java của bạn. Bạn sử dụng chúng khi java không cung cấp chức năng mà bạn cần.

##### Native Method Libraries
Native Method Libraries là tập hợp các Native Libraries được yêu cầu cho Execution Engine .

## :large_blue_diamond: **Tìm hiểu cách sử dụng một JVM đơn giản(AJVM)**
Thực hiện cài đặt, chạy thử một JVM đơn giản được phát triển với AS3 mang tên AJVM.

## :large_blue_diamond: **Phân chia công việc** 
1. Công việc chung:
    - Tìm hiểu khái quát về lịch sử ra đời và phát triển của ngôn ngữ Java
    - Tìm hiểu cơ chế hoạt động của một chương trình Java đơn giản
    - Trả lời những câu hỏi hiểu biết ban đầu về Java Virtual Machine và kiến trúc của một JVM
    - Khắc phục những lỗi còn xảy ra trong mã nguồn mà giáo viên cung cấp
2. Công việc riêng:
    
    ##### Đặng Quang Vinh:
    - Thực hiện cài đặt mã nguồn AJVM
    - Tìm hiểu, sửa những lỗi còn tồn tại
    - Lên kế hoạch thực hiện các công việc cần thiết
    - Viết báo cáo file markdown README.md
    
    ##### Nguyễn Công Hậu:
    - Thực hiện cài đặt mã nguồn AJVM
    - Thực hiện báo cáo file word
    - Nghiên cứu vai trò của JVM đối với ngôn ngữ Java
    
    ##### Phạm Văn Khải:
    - Tìm hiểu và dịch bài báo
    - Thực hiện cài AJVM
    
    ##### Nguyễn Văn Huy:
    - Thực hiện cài đặt mã nguồn AJVM
    - Tìm hiểu thêm về JVM theo các nguồn khác bài báo

## :large_blue_diamond: **Tổng kết** 
Sau quá trình không ngừng nghỉ tìm kiếm, nghiên cứu các nguồn tài liệu cùng với sự giúp đỡ của thầy Bùi Sỹ Nguyên, nhóm đã trau dồi, bổ sung thêm được một lượng lớn kiến thức về:
- Lịch sử ra đời và phát triển của ngôn ngữ Java
- Máy ảo Java
- Kiến trúc JVM và cách nó vận hành
- Cách cài đặt/sử dụng thử một JVM đơn giản được xây dựng trên nền tảng ngôn ngữ ActionScript3

*Tập thể nhóm SE04-21.1 qua đây muốn gủi đến thầy Bùi Sỹ Nguyên lời cảm ơn chân thành nhất. Chúc thầy luôn mạnh khỏe và công tác gặt hái được nhiều thành công!*
---
## :large_blue_diamond: *Tài liệu tham khảo*
1. *What is Java Virtual Machine (http://net-informations.com/java/intro/jvm.htm)*
2. *How JVM Works – JVM Architecture? (https://www.geeksforgeeks.org/jvm-works-jvm-architecture/)*
3. *AJVM – Java Virtual Machine Implemented in ActionScript 3.0 by Arkadiusz Janik, Jakub Krawczyk*