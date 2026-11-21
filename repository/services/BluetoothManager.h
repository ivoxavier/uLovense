#ifndef BLUETOOTHMANAGER_H
#define BLUETOOTHMANAGER_H

#include <QObject>
#include <QBluetoothDeviceDiscoveryAgent>
#include <QBluetoothDeviceInfo>

class BluetoothManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool scanning READ scanning NOTIFY scanningChanged)

public:
    explicit BluetoothManager(QObject *parent = nullptr);

    bool scanning() const;

    Q_INVOKABLE void startScan();
    Q_INVOKABLE void stopScan();

signals:
    void scanningChanged();
    void deviceFound(QString name, QString address, bool lowEnergy);
    void scanFinished();
    void scanError(QString message);

private slots:
    void onDeviceDiscovered(const QBluetoothDeviceInfo &info);
    void onScanFinished();
    void onScanError(QBluetoothDeviceDiscoveryAgent::Error error);

private:
    QBluetoothDeviceDiscoveryAgent *discoveryAgent;
    bool m_scanning;
};

#endif
