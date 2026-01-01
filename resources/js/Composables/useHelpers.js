import { usePage } from '@inertiajs/vue3';
import moment from 'moment-timezone';

export function useHelpers() {
    // Format the currency with the correct symbol and position from settings
    const formatCurrency = (value, sym = '') => {
        const position = usePage().props.settings.currency_position;
        const symbol = sym || usePage().props.settings.currency.symbol;
        const decimalSeparator = usePage().props.settings.currency.decimal_separator;
        const thousandSeparator = usePage().props.settings.currency.thousand_separator;

        if (position === 'prefix_space') {
            return symbol + ' ' + numberFormat(value, 2, decimalSeparator, thousandSeparator);
        } else if (position === 'suffix_space') {
            return numberFormat(value, 2, decimalSeparator, thousandSeparator) + ' ' + symbol;
        } else if (position === 'suffix') {
            return numberFormat(value, 2, decimalSeparator, thousandSeparator) + symbol;
        } else if (position === 'prefix') {
            return symbol + numberFormat(value, 2, decimalSeparator, thousandSeparator);
        }
    };

    // Format the date with given format
    const formatDate = (value, format = usePage().props.settings.date_format) => {
        return moment(value).format(format);
    };

    // Format the datetime with given format
    const formatDateTime = (value, format = usePage().props.settings.date_format, whichOne = 'all') => {
        const settings = usePage().props.settings;
        const is24Hour = settings.time_format === '24' || settings.time_24_hour === true;
        const timeFormat = is24Hour ? 'HH:mm' : 'hh:mm A';

        if (whichOne === 'all') {
            return moment(value).format(format + ' ' + timeFormat);
        } else if (whichOne === 'date') {
            return moment(value).format(format);
        } else if (whichOne === 'time') {
            return moment(value).format(timeFormat);
        }
    };

    // Format vue-datepicker date range
    const formatRangePicker = (date) => {
        const [startDate, endDate] = date;

        // Check if both start and end dates are present
        if (!endDate) {
            const formattedStartDate = moment(startDate).format(usePage().props.settings.date_format);
            const formattedEndDate = moment().format(usePage().props.settings.date_format);
            return `${formattedStartDate} to ${formattedEndDate}`;
        }

        const formattedStartDate = moment(startDate).format(usePage().props.settings.date_format);
        const formattedEndDate = moment(endDate).format(usePage().props.settings.date_format);

        return `${formattedStartDate} to ${formattedEndDate}`;
    };

    // Count current row number
    const currentRow = (index, pagination) => {
        return (pagination.current_page - 1) * pagination.per_page + index + 1;
    };

    function formatUnit(product) {
        if (product.unit) {
            return product.quantity + ' ' + product.unit.short_name;
        }
        return product.quantity;
    }

    function formatStock(stockInBaseUnit, productUnits) {
        if (stockInBaseUnit != null && productUnits != null) {
            // Ensure correct ascending order:
            const sortedUnits = productUnits.sort((a, b) => a.operation_value - b.operation_value);

            // Find the largest unit that fits the stock without exceeding:
            let selectedUnit = sortedUnits.find((unit) => stockInBaseUnit / unit.operation_value <= 1);

            // Fallback if no unit fits within 1 or initial stock is 0:
            if (!selectedUnit || stockInBaseUnit === 0) {
                selectedUnit = sortedUnits[sortedUnits.length - 1];
            }

            // Calculate remaining quantity after using selected unit:
            let remainingQuantity = stockInBaseUnit;
            if (selectedUnit) {
                remainingQuantity -=
                    Math.floor(stockInBaseUnit / selectedUnit.operation_value) * selectedUnit.operation_value;
            }

            // Determine if next smaller unit is needed based on threshold:
            const threshold = selectedUnit.operation_value / 100; // Adjust as needed
            const needNextSmallerUnit = remainingQuantity >= threshold;

            // Use both units if remaining quantity is significant:
            if (needNextSmallerUnit) {
                if (productUnits.length > 1) {
                    const nextSmallerUnit = sortedUnits[sortedUnits.indexOf(selectedUnit) - 1];

                    const nextSmallerQuantity = Math.floor(remainingQuantity / nextSmallerUnit.operation_value);

                    // Adjust remaining quantity:
                    remainingQuantity -= nextSmallerQuantity * nextSmallerUnit.operation_value;

                    // Format and return the full stock representation:
                    return `${Math.floor(stockInBaseUnit / selectedUnit.operation_value)} ${
                        selectedUnit.unit_code
                    } ${nextSmallerQuantity} ${nextSmallerUnit.unit_code}`;
                } else {
                    // Simply format the stock using the selected unit:
                    return `${stockInBaseUnit / selectedUnit.operation_value} ${selectedUnit.unit_code}`;
                }
            } else {
                // Simply format the stock using the selected unit:
                return `${Math.floor(stockInBaseUnit / selectedUnit.operation_value)} ${selectedUnit.unit_code}`;
            }
        } else {
            return 'N/A';
        }
    }

    return { formatCurrency, formatDate, formatDateTime, formatRangePicker, currentRow, formatStock };
}

// Helper function for number formatting
function numberFormat(
    number,
    decimals,
    decimalSeparator,
    thousandSeparator,
    decimalNeeded = usePage().props.settings.decimal_point == 1 ? true : false,
) {
    number = parseFloat(number);
    if (!isFinite(number) || isNaN(number)) {
        return '';
    }

    // Round to nearest integer if decimals are not needed
    if (!decimalNeeded) {
        number = Math.round(number);
        decimals = 0;
    }

    const fixedNumber = number.toFixed(decimals);
    const parts = fixedNumber.split('.');

    // Check if the decimal part is "00"
    if (parts.length > 1 && parts[1] === '00') {
        return parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, thousandSeparator);
    }

    const integerPart = parts[0];
    const decimalPart = parts.length > 1 ? decimalSeparator + parts[1] : '';

    return integerPart.replace(/\B(?=(\d{3})+(?!\d))/g, thousandSeparator) + decimalPart;
}
