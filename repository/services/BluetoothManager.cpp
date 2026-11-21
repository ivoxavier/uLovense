#include "BluetoothManager.h"

#include <QDebug>
#include <QBluetoothAddress>

BluetoothManager::BluetoothManager(QObject *parent)
    : QObject(parent),
    discoveryAgent(new QBluetoothDeviceDiscoveryAgent(this)),
    m_scanning(false)
{
    qInfo() << "[uLovense][Bluetooth] BluetoothManager iniciado";

    discoveryAgent->setLowEnergyDiscoveryTimeout(10000);

    connect(discoveryAgent,
            &QBluetoothDeviceDiscoveryAgent::deviceDiscovered,
            this,
            &BluetoothManager::onDeviceDiscovered);

    connect(discoveryAgent,
            &QBluetoothDeviceDiscoveryAgent::finished,
            this,
            &BluetoothManager::onScanFinished);

    connect(discoveryAgent,
            QOverload<QBluetoothDeviceDiscoveryAgent::Error>::of(
                &QBluetoothDeviceDiscoveryAgent::error),
            this,
            &BluetoothManager::onScanError);
}

bool BluetoothManager::scanning() const
{
    return m_scanning;
}

void BluetoothManager::startScan()
{
    if (discoveryAgent->isActive()) {
        qWarning() << "[uLovense][Bluetooth] Pesquisa já em curso";
            return;
    }

    qInfo() << "[uLovense][Bluetooth] A iniciar pesquisa BLE...";

    m_scanning = true;
    emit scanningChanged();

    discoveryAgent->start(
        QBluetoothDeviceDiscoveryAgent::LowEnergyMethod
        );
}

void BluetoothManager::stopScan()
{
    if (!discoveryAgent->isActive()) {
        qWarning() << "[uLovense][Bluetooth] Não existe pesquisa ativa";
            return;
    }

    qInfo() << "[uLovense][Bluetooth] A cancelar pesquisa BLE...";
    discoveryAgent->stop();
}

void BluetoothManager::onDeviceDiscovered(
    const QBluetoothDeviceInfo &info)
{
    const QString name = info.name();
    const QString address = info.address().toString();

    const bool lowEnergy =
        info.coreConfigurations().testFlag(
            QBluetoothDeviceInfo::LowEnergyCoreConfiguration
            );

    qInfo() << "[uLovense][Bluetooth] Dispositivo encontrado:";
    qInfo() << "  Nome:" << name;
    qInfo() << "  Endereço:" << address;
        qInfo() << "  BLE:" << lowEnergy;

    if (name.contains("LVS", Qt::CaseInsensitive) ||
        name.contains("Lush", Qt::CaseInsensitive) ||
        name.contains("Lovense", Qt::CaseInsensitive)) {
        qInfo() << "[uLovense][Bluetooth] Possível dispositivo Lovense!";
    }

    emit deviceFound(name, address, lowEnergy);
}

void BluetoothManager::onScanFinished()
{
    m_scanning = false;
    emit scanningChanged();

    qInfo() << "[uLovense][Bluetooth] Pesquisa BLE concluída";

        emit scanFinished();
}

void BluetoothManager::onScanError(
    QBluetoothDeviceDiscoveryAgent::Error error)
{
    m_scanning = false;
    emit scanningChanged();

    const QString message = discoveryAgent->errorString();

    qWarning() << "[uLovense][Bluetooth] ERRO:" << error;
    qWarning() << "[uLovense][Bluetooth] Detalhes:" << message;

    emit scanError(message);
}
