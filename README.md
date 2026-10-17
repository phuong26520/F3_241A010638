Lab F3 - Nhập liệu và Form trong Flutter - Đăng ký học phần

Thông tin sinh viên: Nguyễn Hoài Phương - MSSV 241A010638 - Lớp LTTTBDD - Môn INT4211 Lập trình trên các thiết bị di động - Tuần 7. Project f3_form tạo bằng lệnh flutter create với org vn.edu.vhu.ltdd, ngôn ngữ Dart theo Material 3, Flutter 3.47.3.

Mô tả ngắn gọn

App Đăng ký học phần gồm một màn hình là một Form điều khiển bằng GlobalKey của FormState, đặt trong ListView để cuộn được khi bàn phím hiện lên. Biểu mẫu có đủ bảy loại control theo đặc tả: ba TextFormField cho họ tên, MSSV và email, một DropdownButtonFormField cho học phần, một RadioGroup bao ngoài hai RadioListTile cho hệ đào tạo, ba CheckboxListTile cho buổi học giữ trạng thái trong một Set, một Slider chọn số tín chỉ từ 10 đến 24 với 14 nấc, một SwitchListTile cho nhận thông báo, cùng hai nút ĐĂNG KÝ và Làm lại. Form đặt autovalidateMode là onUserInteraction nên lỗi hiện ngay khi người dùng gõ.

Cấu trúc thư mục chính

lib/main.dart chứa toàn bộ ứng dụng gồm MyApp, RegisterPage và _RegisterPageState
test/widget_test.dart chứa sáu widget test phủ Checkpoint và hai bài nâng cao
pubspec.yaml khai báo tên package f3_form và các dependency mặc định

Các chức năng đã hoàn thành theo thang điểm

Đủ bảy loại control theo đặc tả, title của MaterialApp là F3_241A010638. Validator đúng cho cả bốn trường bắt buộc: họ tên không rỗng và tối thiểu ba ký tự, MSSV khớp biểu thức chính quy đúng mười chữ số, email khớp biểu thức định dạng, học phần không được null. Control ngoài Form được kiểm tra thủ công bằng if và báo bằng SnackBar khi chưa chọn buổi học nào. Hộp thoại tóm tắt hiển thị đủ tám dòng dữ liệu đúng với những gì đã nhập, nút Làm lại gọi reset() của Form, clear() ba controller và setState đưa mọi biến về giá trị ban đầu. Ba controller đều có dòng dispose tương ứng và super.dispose() gọi cuối cùng. Bảng đối chiếu control Android và Flutter đã điền đủ cột của bài. Hai bài nâng cao NC2 và NC3 đã làm.

Bài nâng cao đã thực hiện

NC2 - Kiểm tra phụ thuộc giữa hệ đào tạo và buổi học. Trong hàm _dangKy, sau dòng kiểm tra hopLe và trước showDialog, thêm một if với điều kiện _heDaoTao == 'Vừa làm vừa học' && !_buoiDaChon.contains('Tối'). Nếu đúng thì showSnackBar nội dung Hệ vừa làm vừa học bắt buộc chọn buổi Tối rồi return, không cho mở hộp thoại xác nhận. Vị trí đặt ở cuối là có chủ đích vì validate() phải chạy trước để mọi ô hiện lỗi cùng một lượt, người dùng không phải sửa lỗi theo nhiều đợt. Ràng buộc này không viết bằng validator được vì nó phụ thuộc giá trị của hai control khác nhau và RadioGroup không nằm trong cơ chế của Form.

NC3 - Đếm ký tự còn lại cho ô Họ tên. Thêm maxLength: 50 vào TextFormField họ tên. Để bộ đếm hiển thị số ký tự còn lại thay vì số đã dùng, đặt counterText trong InputDecoration theo dạng Còn lại ${50 - value.text.length} ký tự. Vì InputDecoration tạo trong build chỉ cập nhật khi State dựng lại mà gõ chữ vào controller không tự trigger setState, toàn bộ TextFormField được bọc trong ValueListenableBuilder với valueListenable là _hoTenCtrl; TextEditingController vốn là một ValueListenable nên mỗi lần gõ builder chạy lại và tạo InputDecoration với con số mới, chỉ dựng lại đúng ô họ tên thay vì cả màn hình.

Cách chạy và kiểm thử

Cần Flutter 3.35 trở lên vì bài dùng RadioGroup và tham số initialValue của DropdownButtonFormField. Mở thư mục project rồi chạy flutter pub get, flutter run. Trên bản cũ hơn 3.35 phải đổi initialValue thành value và chuyển groupValue cùng onChanged về từng RadioListTile. Kiểm tra tự động bằng flutter analyze và flutter test, bộ test gồm sáu case về form trống, MSSV sai, nhập đúng, ràng buộc NC2, bộ đếm NC3 và nút Làm lại.

Ghi chú kỹ thuật

CheckboxListTile, Slider và SwitchListTile không phải FormField nên validate() không biết đến, phải tự kiểm tra bằng if và báo bằng SnackBar. inputFormatters chặn ngay lúc gõ nhưng vẫn phải có validator vì người dùng có thể dán dữ liệu từ nơi khác. DropdownButtonFormField chỉ nhận giá trị ban đầu lúc khởi tạo nên muốn đưa về trống khi Làm lại phải đổi key bằng ValueKey(_monHoc) để Flutter dựng lại widget. ListView được dùng thay Column để bàn phím không che mất ô nhập.
