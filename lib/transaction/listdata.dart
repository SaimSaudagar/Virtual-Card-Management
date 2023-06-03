import 'package:project/transaction/transac.dart';

List<Money> geter() {
  Money upwork = Money();
  upwork.name = 'Upwork';
  upwork.fee = '650';
  upwork.time = 'today';
  upwork.image = 'Upwork.png';
  upwork.buy = false;

  Money starbucks = Money();
  starbucks.name = 'Starbucks';
  starbucks.fee = '15';
  starbucks.time = 'today';
  starbucks.image = 'Starbucks.png';
  starbucks.buy = true;

  Money Utilities = Money();
  Utilities.name = 'Utilities';
  Utilities.fee = '50';
  Utilities.time = 'Jan 30 2023';
  Utilities.image = 'Utility.png';
  Utilities.buy = true;

  Money Education = Money();
  Education.name = 'Education';
  Education.fee = '100';
  Education.time = 'April 30 2023';
  Education.image = 'Education.png';
  Education.buy = true;

  return [upwork, starbucks, Utilities, Education];
}
