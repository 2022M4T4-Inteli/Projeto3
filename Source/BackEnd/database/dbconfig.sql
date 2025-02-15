PGDMP     4                    z            estapar_management    15.1    15.1                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16455    estapar_management    DATABASE     �   CREATE DATABASE estapar_management WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
 "   DROP DATABASE estapar_management;
                postgres    false            �            1259    16644    manager    TABLE     �   CREATE TABLE public.manager (
    manager_id integer NOT NULL,
    manager_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL
);
    DROP TABLE public.manager;
       public         heap    postgres    false            �            1259    16643    manager_manager_id_seq    SEQUENCE     �   CREATE SEQUENCE public.manager_manager_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.manager_manager_id_seq;
       public          postgres    false    215                       0    0    manager_manager_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.manager_manager_id_seq OWNED BY public.manager.manager_id;
          public          postgres    false    214            �            1259    16666    services    TABLE       CREATE TABLE public.services (
    service_id integer NOT NULL,
    estimate_time double precision NOT NULL,
    distance double precision NOT NULL,
    prism integer NOT NULL,
    fk_rfid_code character varying(255) NOT NULL,
    status character varying(255) NOT NULL
);
    DROP TABLE public.services;
       public         heap    postgres    false            �            1259    16665    services_service_id_seq    SEQUENCE     �   CREATE SEQUENCE public.services_service_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.services_service_id_seq;
       public          postgres    false    219                       0    0    services_service_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.services_service_id_seq OWNED BY public.services.service_id;
          public          postgres    false    218            �            1259    16655    vallet    TABLE     �   CREATE TABLE public.vallet (
    vallet_id integer NOT NULL,
    rfid_code character varying(255) NOT NULL,
    vallet_name character varying(255) NOT NULL,
    fk_manager_id integer NOT NULL
);
    DROP TABLE public.vallet;
       public         heap    postgres    false            �            1259    16654    vallet_vallet_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vallet_vallet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.vallet_vallet_id_seq;
       public          postgres    false    217                       0    0    vallet_vallet_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.vallet_vallet_id_seq OWNED BY public.vallet.vallet_id;
          public          postgres    false    216            o           2604    16647    manager manager_id    DEFAULT     x   ALTER TABLE ONLY public.manager ALTER COLUMN manager_id SET DEFAULT nextval('public.manager_manager_id_seq'::regclass);
 A   ALTER TABLE public.manager ALTER COLUMN manager_id DROP DEFAULT;
       public          postgres    false    214    215    215            q           2604    16669    services service_id    DEFAULT     z   ALTER TABLE ONLY public.services ALTER COLUMN service_id SET DEFAULT nextval('public.services_service_id_seq'::regclass);
 B   ALTER TABLE public.services ALTER COLUMN service_id DROP DEFAULT;
       public          postgres    false    219    218    219            p           2604    16658    vallet vallet_id    DEFAULT     t   ALTER TABLE ONLY public.vallet ALTER COLUMN vallet_id SET DEFAULT nextval('public.vallet_vallet_id_seq'::regclass);
 ?   ALTER TABLE public.vallet ALTER COLUMN vallet_id DROP DEFAULT;
       public          postgres    false    216    217    217                      0    16644    manager 
   TABLE DATA           L   COPY public.manager (manager_id, manager_name, email, password) FROM stdin;
    public          postgres    false    215   H!                 0    16666    services 
   TABLE DATA           d   COPY public.services (service_id, estimate_time, distance, prism, fk_rfid_code, status) FROM stdin;
    public          postgres    false    219   �!                 0    16655    vallet 
   TABLE DATA           R   COPY public.vallet (vallet_id, rfid_code, vallet_name, fk_manager_id) FROM stdin;
    public          postgres    false    217   �"                  0    0    manager_manager_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.manager_manager_id_seq', 1, true);
          public          postgres    false    214                       0    0    services_service_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.services_service_id_seq', 25, true);
          public          postgres    false    218                       0    0    vallet_vallet_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.vallet_vallet_id_seq', 4, true);
          public          postgres    false    216            s           2606    16651    manager Manager_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.manager
    ADD CONSTRAINT "Manager_pkey" PRIMARY KEY (manager_id);
 @   ALTER TABLE ONLY public.manager DROP CONSTRAINT "Manager_pkey";
       public            postgres    false    215            w           2606    16662    vallet Vallet_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.vallet
    ADD CONSTRAINT "Vallet_pkey" PRIMARY KEY (rfid_code);
 >   ALTER TABLE ONLY public.vallet DROP CONSTRAINT "Vallet_pkey";
       public            postgres    false    217            u           2606    16653    manager manager_email_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_email_key UNIQUE (email);
 C   ALTER TABLE ONLY public.manager DROP CONSTRAINT manager_email_key;
       public            postgres    false    215            {           2606    16672    services services_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (service_id);
 @   ALTER TABLE ONLY public.services DROP CONSTRAINT services_pkey;
       public            postgres    false    219            y           2606    16664    vallet vallet_vallet_id_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.vallet
    ADD CONSTRAINT vallet_vallet_id_key UNIQUE (vallet_id);
 E   ALTER TABLE ONLY public.vallet DROP CONSTRAINT vallet_vallet_id_key;
       public            postgres    false    217            }           2606    16686 #   services services_fk_rfid_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_fk_rfid_code_fkey FOREIGN KEY (fk_rfid_code) REFERENCES public.vallet(rfid_code);
 M   ALTER TABLE ONLY public.services DROP CONSTRAINT services_fk_rfid_code_fkey;
       public          postgres    false    217    3191    219            |           2606    16681     vallet vallet_fk_manager_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.vallet
    ADD CONSTRAINT vallet_fk_manager_id_fkey FOREIGN KEY (fk_manager_id) REFERENCES public.manager(manager_id);
 J   ALTER TABLE ONLY public.vallet DROP CONSTRAINT vallet_fk_manager_id_fkey;
       public          postgres    false    215    3187    217               m   x�3�tM)K�I�W��)K�L���A<���Ă�"���\N�$C��D���Lsǔ��@sO�Hcc�TW��H���r�����LOˬ��������`��p�=... �F"�         �   x���=�0Fg�0U��+$FN�����qB;R��J���}ID��R+1u6��
Ӊ�d��s~=�
2z�$cq��	�t&\AL���Gd���Q/����iE%,��1�p9�J��0+{�;ѶS�r���J삞�tP[���=Y��rLY�̿+�b��b�HR?�$�u����
b\���,��ߍ�+�r�77ߗ������?��q�7��b         n   x��A� ׏Sp��]~I��#t�U�$F�����ۙ�X���g��<Jɛ�,?��
�(:�<��Y���x�xJ��\w���XEr��GkR�w���y�>���B�     