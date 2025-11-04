import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data - replace with your state management
    final List<TransactionItem> transactions = [
      TransactionItem(
        title: 'Daily Disbursement',
        subtitle: 'Transfer to OLUGBOHUNMI SODIPE • 7044059896',
        amount: '-₦5,000.00',
        date: 'Today, 8:00 AM',
        status: TransactionStatus.success,
        icon: Icons.arrow_downward,
      ),
      TransactionItem(
        title: 'Deposit via Flutterwave',
        subtitle: 'Card ending •••• 1234',
        amount: '+₦50,000.00',
        date: 'Yesterday, 3:15 PM',
        status: TransactionStatus.success,
        icon: Icons.account_balance_wallet,
      ),
      TransactionItem(
        title: 'Daily Disbursement',
        subtitle: 'Transfer to OLUGBOHUNMI SODIPE • 7044059896',
        amount: '-₦5,000.00',
        date: 'Oct 31, 8:00 AM',
        status: TransactionStatus.success,
        icon: Icons.arrow_downward,
      ),
      TransactionItem(
        title: 'Deposit via Paystack',
        subtitle: 'Bank Transfer • REF: TXN123456',
        amount: '+₦30,000.00',
        date: 'Oct 30, 11:42 AM',
        status: TransactionStatus.failed,
        icon: Icons.account_balance_wallet,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF007AFF)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Transaction History',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Color(0xFF007AFF)),
            onPressed: () {
              // Filter action
            },
          ),
        ],
      ),
      body: transactions.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return _TransactionCard(transaction: tx);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No transactions yet',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Your deposits and disbursements will appear here',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Transaction Item Model
class TransactionItem {
  final String title;
  final String subtitle;
  final String amount;
  final String date;
  final TransactionStatus status;
  final IconData icon;

  TransactionItem({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.status,
    required this.icon,
  });
}

enum TransactionStatus { success, failed, pending }

// Reusable Transaction Card
class _TransactionCard extends StatelessWidget {
  final TransactionItem transaction;

  const _TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final bool isCredit = transaction.amount.startsWith('+');
    final Color amountColor = isCredit
        ? const Color(0xFF34C759)
        : const Color(0xFF333333);
    final Color statusColor = transaction.status == TransactionStatus.success
        ? const Color(0xFF34C759)
        : transaction.status == TransactionStatus.failed
        ? const Color(0xFFFF3B30)
        : const Color(0xFFFF9500);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon Circle
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F7),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Icon(
              transaction.icon,
              color: const Color(0xFF007AFF),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      transaction.status == TransactionStatus.success
                          ? Icons.check_circle
                          : transaction.status == TransactionStatus.failed
                          ? Icons.error
                          : Icons.access_time,
                      size: 14,
                      color: statusColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      transaction.status == TransactionStatus.success
                          ? 'Success'
                          : transaction.status == TransactionStatus.failed
                          ? 'Failed'
                          : 'Pending',
                      style: TextStyle(
                        fontSize: 12,
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      transaction.date,
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Amount
          Text(
            transaction.amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}
