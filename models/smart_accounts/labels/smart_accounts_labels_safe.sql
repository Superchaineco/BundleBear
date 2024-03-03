{{ config
(
    materialized = 'incremental',
    unique_key = ['tx_hash', 'address']
)
}}

select
    'ethereum' as blockchain,
    et.FROM_ADDRESS as address,
    et.BLOCK_TIMESTAMP as creation_time,
    et.TRANSACTION_HASH as tx_hash,
from ETHEREUM.RAW.TRACES et 
inner join BUNDLEBEAR.DBT_KOFI.SMART_ACCOUNT_LABELS_SAFE_SINGLETONS s
    on et.TO_ADDRESS = s.address
    and s.blockchain = 'ethereum'
    and et.ERROR is null
    and et.call_type = 'delegatecall' 
    and SELECTOR in ('0x0ec78d9e','0xa97ab18a', '0xb63e800d')
    and et.gas_used > 10000 
    {% if not is_incremental() %}
    and et.BLOCK_TIMESTAMP > '2018-11-24' 
    {% endif %}
    {% if is_incremental() %}
    and et.BLOCK_TIMESTAMP >= CURRENT_TIMESTAMP() - interval '3 day' 
    {% endif %}

union all
select
    'polygon' as blockchain,
    et.FROM_ADDRESS as address,
    et.BLOCK_TIMESTAMP as creation_time,
    et.TRANSACTION_HASH as tx_hash,
from POLYGON.RAW.TRACES et 
inner join BUNDLEBEAR.DBT_KOFI.SMART_ACCOUNT_LABELS_SAFE_SINGLETONS s
    on et.TO_ADDRESS = s.address
    and s.blockchain = 'polygon'
    and et.ERROR is null
    and et.call_type = 'delegatecall' 
    and SELECTOR in ('0x0ec78d9e','0xa97ab18a', '0xb63e800d')
    and et.gas_used > 10000 
    {% if not is_incremental() %}
    and et.BLOCK_TIMESTAMP > '2021-03-07' 
    {% endif %}
    {% if is_incremental() %}
    and et.BLOCK_TIMESTAMP >= CURRENT_TIMESTAMP() - interval '3 day' 
    {% endif %}

union all
select
    'optimism' as blockchain,
    et.FROM_ADDRESS as address,
    et.BLOCK_TIMESTAMP as creation_time,
    et.TRANSACTION_HASH as tx_hash,
from OPTIMISM.RAW.TRACES et 
inner join BUNDLEBEAR.DBT_KOFI.SMART_ACCOUNT_LABELS_SAFE_SINGLETONS s
    on et.TO_ADDRESS = s.address
    and s.blockchain = 'optimism'
    and et.ERROR is null
    and et.call_type = 'delegatecall' 
    and SELECTOR in ('0x0ec78d9e','0xa97ab18a', '0xb63e800d')
    and et.gas_used > 10000 
    {% if not is_incremental() %}
    and et.BLOCK_TIMESTAMP > '2021-11-17' 
    {% endif %}
    {% if is_incremental() %}
    and et.BLOCK_TIMESTAMP >= CURRENT_TIMESTAMP() - interval '3 day' 
    {% endif %}

union all
select
    'arbitrum' as blockchain,
    et.FROM_ADDRESS as address,
    et.BLOCK_TIMESTAMP as creation_time,
    et.TRANSACTION_HASH as tx_hash,
from ARBITRUM.RAW.TRACES et 
inner join BUNDLEBEAR.DBT_KOFI.SMART_ACCOUNT_LABELS_SAFE_SINGLETONS s
    on et.TO_ADDRESS = s.address
    and s.blockchain = 'arbitrum'
    and et.ERROR is null
    and et.call_type = 'delegatecall' 
    and SELECTOR in ('0x0ec78d9e','0xa97ab18a', '0xb63e800d')
    and et.gas_used > 10000 
    {% if not is_incremental() %}
    and et.BLOCK_TIMESTAMP > '2021-06-20' 
    {% endif %}
    {% if is_incremental() %}
    and et.BLOCK_TIMESTAMP >= CURRENT_TIMESTAMP() - interval '3 day' 
    {% endif %}