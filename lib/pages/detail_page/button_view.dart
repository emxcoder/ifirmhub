part of 'device_detail_page.dart';

class FirmwareButton extends ConsumerWidget {
  const FirmwareButton({
    super.key,
    required this.identifier,
  });

  final String identifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          if (!hasInternetGlobal(ref)) {
            counterTryState(ref).state++;
            notificationService.showOffline(context);
          } else {
            context.pushNamed(firmwarePageRoute.name!,
                pathParameters: {'identifier': identifier});
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'View Firmwares',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
