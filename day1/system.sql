1. cmd â ����

-- �������� ���� ����...
2. sqlplus /nolog �Է� ����

3. SQL>conn /as sysdba

SQL>alter user system identified by ���ο��ȣ
SQL>alter user sys identified by ���ο��ȣ

SQL>conn system/ ���ο��ȣ

-- ����Ȯ��

--SQL>show user

-- ����Ŭ 12���� �̻���ʹ� �Ʒ��� �����ؾ�
-- �Ϲ����� ���� �ۼ��� ������
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

-- ���� ������ ���� �ѹ� ����
-- ���� ���� ���ϸ� �Ʒ�ó�� ������ �ۼ��ؾ���
CREATE USER c##busan_06 IDENTIFIED BY dbdb;

-- 1. ����� �����ϱ�

CREATE USER busan_06 
    IDENTIFIED BY dbdb;
    
-- �н����� �����ϱ�
ALTER USER busan_06
    IDENTIFIED BY �����н�����;
    
-- ����� �����ϱ�
DROP USER busan_06;

-- 2. ���Ѻο��ϱ�
GRANT CONNECT, RESOURCE, DBA TO busan_06;

-- ���� ȸ���ϱ�
REVOKE DBA FROM busan_06;

