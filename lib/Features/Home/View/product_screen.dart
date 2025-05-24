import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductEditorScreen extends StatefulWidget {
  @override
  _ProductEditorScreenState createState() => _ProductEditorScreenState();
}

class _ProductEditorScreenState extends State<ProductEditorScreen> {
  final TextEditingController quantityController = TextEditingController();
  DateTime? productionDate;
  DateTime? expiryDate;

  final daysBefore = {'Y': '0', 'M': '0', 'D': '0'};
  bool notifyBefore = false;

  Future<void> pickDate(BuildContext context, Function(DateTime) onPicked) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      locale: const Locale('ar'), // Arabic support
    );
    if (date != null) {
      onPicked(date);
    }
  }

  int calculateRemainingDays() {
    if (expiryDate == null) return 0;
    return expiryDate!.difference(DateTime.now()).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final remainingDays = calculateRemainingDays();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text("تحرير المنتج")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network("https://housefood.africa/wp-content/uploads/2022/04/beef.webp"), // your static image
                ),
                SizedBox(height: 16),
                Text("الكمية"),
                TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
                SizedBox(height: 16),
                Text("تاريخ الإنتاج"),
                ListTile(
                  title: Text(productionDate == null
                      ? "اختر تاريخ الإنتاج"
                      : DateFormat('yyyy-MM-dd').format(productionDate!)),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () => pickDate(context, (date) => setState(() => productionDate = date)),
                ),
                Text("تاريخ الانتهاء"),
                ListTile(
                  title: Text(expiryDate == null
                      ? "اختر تاريخ الانتهاء"
                      : DateFormat('yyyy-MM-dd').format(expiryDate!)),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () => pickDate(context, (date) => setState(() => expiryDate = date)),
                ),
                SizedBox(height: 8),
                CheckboxListTile(
                  title: Text("إرسال تذكير قبل انتهاء الوقت بـ"),
                  value: notifyBefore,
                  onChanged: (val) => setState(() => notifyBefore = val!),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                if (notifyBefore)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ['Y', 'M', 'D'].map((unit) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: TextField(
                            onChanged: (val) => daysBefore[unit] = val,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: unit,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                SizedBox(height: 16),
                Text("الأيام المتبقية: ${remainingDays < 0 ? 0 : remainingDays} يوم"),
                SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Save logic here
                    },
                    child: Text("حفظ"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
